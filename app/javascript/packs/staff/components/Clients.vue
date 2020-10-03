<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table.elevation-1.pa-4.mt-4(:headers='headers' :items='clients' :search='search' @click:row="pushToClient")
        template(v-slot:top='')
          v-toolbar(flat='')
            v-toolbar-title Clients
            v-spacer
            v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line='' hide-details='')
            v-spacer
            v-dialog(v-model='dialog' max-width='500px')
              template(v-slot:activator='{ on, attrs }')
                v-btn.mb-2(color='primary' dark='' v-bind='attrs' v-on='on')
                  v-icon.mr-3(left) mdi-plus
                  | Add Client
              v-form(ref='form' lazy-validation='')
                v-card.pa-4
                  v-card-title
                    span.headline {{ formTitle }}
                  v-card-text
                    v-container
                      v-row
                        v-col(cols="12")
                          v-text-field(v-model= 'editedItem.full_name' label='Full name' :rules="fullnameRules")
                          v-text-field(v-model='editedItem.email' label='E-mail' :rules="emailRules")
                          v-text-field(v-model='editedItem.phone' label='Phone' :rules="phoneRules")
                          v-select(v-model='editedItem.organizations' :items='organizationNames' :menu-props="{ maxHeight: '400' }" label='Select' multiple='' hint='Pick organizations' persistent-hint='')
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
import validations from 'form_validation_rules'
const { fullnameRules, phoneRules, emailRules } = validations

export default {
  data () {
    return {
      loading: true,
      error: false,
      clients: [],
      organizations: [],
      selected: [],
      valid: true,
      fullnameRules,
      phoneRules,
      emailRules,
      search: '',
      dialog: false,
      dialogDelete: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Full name', value: 'full_name' },
        { text: 'Email', value: 'email' },
        { text: 'Phone', value: 'phone' },
        { text: 'Actions', value: 'actions', sortable: false },
      ],
      editedIndex: -1,
      editedItem: {
        id: '',
        email: '',
        phone: '',
        full_name: '',
        organizations: []
      },
      defaultItem: {
        id: '',
        email: '',
        phone: '',
        full_name: '',
        organizations: []
      },
    }
  },

  created() {
    this.fetchClients()
    this.fetchOrganizations()
  },

  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'New Client' : 'Edit Client'
    },
    organizationNames () {
      return this.organizations.map(v => v['org_name'])
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
    fetchClients () {
      this.loading = true
      setTimeout( () => {
        this.$api.clients.index()
            .then(response => this.clients = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 500)
    },

    fetchOrganizations () {
      this.$api.organizations.index()
          .then(response => this.organizations = response.data)
    },

    save() {
      this.$refs.form.validate()

      Object.assign(this.editedItem['organizations'], this.organizations.filter(o => this.editedItem.organizations.includes(o.org_name)))

      if (this.editedIndex > -1) {
        this.$api.clients.update(this.editedItem)
            .then(response => {
              Object.assign(this.clients[this.editedIndex], response.data)
              this.close()
            })
      } else {
        this.$api.clients.create(this.editedItem)
            .then(response => {
              this.clients.push(response.data)
              this.close()
            })
      }
    },

    editItem (item) {
      this.editedIndex = this.clients.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
    },

    deleteItem (item) {
      this.editedIndex = this.clients.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialogDelete = true
    },

    deleteItemConfirm () {
      this.$api.clients.destroy(this.editedItem)
          .then(response => {
            this.clients.splice(this.editedIndex, 1)
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

    pushToClient(row) {
      this.$router.push({ name: 'client', params: { id: row.id } })
    }
  },

  components: {
    Loading
  }
}
</script>
