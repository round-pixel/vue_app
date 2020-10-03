<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table.elevation-1.pa-4.mt-4(:headers='headers' :items='organizations' :search='search' @click:row="pushToOrganization")
        template(v-slot:top='')
          v-toolbar(flat='')
            v-toolbar-title Organizations
            v-spacer
            v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line='' hide-details='')
            v-spacer
            v-dialog(v-model='dialog' max-width='500px')
              template(v-slot:activator='{ on, attrs }')
                v-btn.mb-2(color='primary' dark='' v-bind='attrs' v-on='on')
                  v-icon.mr-3(left) mdi-plus
                  | Add Organization
              v-card.pa-4
                v-form(ref='form')
                  v-card-title
                    span.headline {{ formTitle }}
                  v-card-text
                    v-container
                      v-row
                        v-col(cols="12")
                          v-text-field(v-model= 'editedItem.org_name' label='Organization name')
                          v-text-field(v-model='editedItem.org_type' label='Organization type')
                          v-text-field(v-model='editedItem.inn' label='INN')
                          v-text-field(v-model='editedItem.ogrn' label='OGRN')
                          v-select(v-model='editedItem.clients' :items='clientEmails' :menu-props="{ maxHeight: '400' }" label='Select' multiple='' hint='Pick clients' persistent-hint='')

                  v-card-actions
                    v-spacer
                    v-btn(color='blue darken-1' text='' @click='close')
                      | Cancel
                    v-btn(color='blue darken-1' text='' @click='save')
                      | Save
            v-dialog(v-model='dialogDelete' max-width='500px')
              v-card
                v-card-title.headline Are you sure you want to delete this item?
                v-card-actions
                  v-spacer
                  v-btn(color='blue darken-1' text='' @click='closeDelete') Cancel
                  v-btn(color='blue darken-1' text='' @click='deleteItemConfirm') OK
                  v-spacer
        template(v-slot:item.actions='{ item }')
          v-icon.mr-2(small='' @click='editItem(item)')
            | mdi-pencil
          v-icon(small='' @click='deleteItem(item)')
            | mdi-delete
        template(v-slot:no-data='')
          v-btn(color='primary' @click='initialize')
            | Reset
</template>

<script>
import Loading from 'components/Loading'

export default {
  data () {
    return {
      loading: true,
      error: false,
      organizations: [],
      clients: [],
      valid: true,
      search: '',
      dialog: false,
      dialogDelete: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Organization name', value: 'org_name' },
        { text: 'Organization type', value: 'org_type', filterable: false },
        { text: 'INN', value: 'inn', filterable: false },
        { text: 'OGRN', value: 'ogrn', filterable: false },
        { text: 'Actions', value: 'actions', sortable: false },
      ],
      editedIndex: -1,
      editedItem: {
        id: '',
        org_name: '',
        org_type: '',
        inn: '',
        ogrn: '',
        clients: []
      },
      defaultItem: {
        id: '',
        org_name: '',
        org_type: '',
        inn: '',
        ogrn: '',
        clients: []
      },
    }
  },

  created() {
    this.fetchOrganizations()
    this.fetchClients()
  },

  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'New Organization' : 'Edit Organization'
    },

    clientEmails () {
      return this.clients.map(v => v['email'])
    }
  },

  watch: {
    dialog (val) {
      val || this.close()
    },
    dialogDelete (val) {
      val || this.closeDelete()
    },
  },

  methods: {
    fetchOrganizations () {
      this.loading = true
      setTimeout( () => {
        this.$api.organizations.index()
            .then(response => this.organizations = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 300)
    },

    fetchClients () {
      this.$api.clients.index()
          .then(response => this.clients = response.data)
    },

    save() {
      this.$refs.form.validate()

      Object.assign(this.editedItem['clients'], this.clients.filter(o => this.editedItem.clients.includes(o.email)))

      if (this.editedIndex > -1) {
        this.$api.organizations.update(this.editedItem)
          .then(response => {
            Object.assign(this.organizations[this.editedIndex], response.data)
            this.close()
          })
      } else {
        this.$api.organizations.create(this.editedItem)
          .then(response => {
            this.organizations.push(response.data)
            this.close()
          })
      }
    },

    editItem (item) {
      this.editedIndex = this.organizations.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
    },

    deleteItem (item) {
      this.editedIndex = this.organizations.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialogDelete = true
    },

    deleteItemConfirm () {
      this.$api.organizations.destroy(this.editedItem)
          .then(response => {
            this.organizations.splice(this.editedIndex, 1)
            this.closeDelete()
          })
          .catch(e => console.log(e.response.data))
    },

    close () {
      this.dialog = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },

    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },

    pushToOrganization(row) {
      this.$router.push({ name: 'organization', params: { id: row.id } })
    }
  },
  components: {
    Loading
  }
}
</script>
