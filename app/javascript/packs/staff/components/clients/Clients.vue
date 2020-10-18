<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table.elevation-1(:headers='headers' :items='clients' :search='search' @click:row="pushToClient")
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
                    span.headline New Client
                  v-card-text
                    v-container
                      v-row
                        v-col(cols="12")
                          v-text-field(v-model= 'newCLient.full_name' label='Full name' :rules="fullnameRules")
                          v-text-field(v-model='newCLient.email' label='E-mail' :rules="emailRules")
                          v-text-field(v-model='newCLient.phone' label='Phone' :rules="phoneRules")
                          v-select(
                            v-model='newCLient.organizations'
                            :items='organizationNames'
                            :menu-props="{ maxHeight: '400' }"
                            label='Select'
                            multiple=''
                            hint='Pick organizations'
                            persistent-hint=''
                          )
                  v-card-actions
                    v-spacer
                    v-btn(color='blue darken-1' text='' @click='close')
                      | Cancel
                    v-btn(color='blue darken-1' text='' @click='save')
                      | Save
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
      valid: true,
      fullnameRules,
      phoneRules,
      emailRules,
      search: '',
      dialog: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Full name', value: 'full_name' },
        { text: 'Email', value: 'email' },
        { text: 'Phone', value: 'phone' },
      ],
      newCLient: {
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
    organizationNames () {
      return this.organizations.map(v => v.org_name)
    }
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

    save () {
      this.$refs.form.validate()

      Object.assign(this.newCLient.organizations, this.organizations.filter(o => this.newCLient.organizations.includes(o.org_name)))

      this.$api.clients.create(this.newCLient)
          .then(response => {
            this.clients.push(response.data)
            this.close()
          })
    },

    close () {
      this.dialog = false
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
