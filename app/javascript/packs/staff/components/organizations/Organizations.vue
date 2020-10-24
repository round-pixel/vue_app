<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table.elevation-1.pa-4.mt-4(:headers='headers' :items='organizations' :search='search' @click:row="pushToOrganization")
        template(v-slot:top)
          v-toolbar(flat)
            v-toolbar-title Organizations
            v-spacer
            v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line hide-details)
            v-spacer
            v-dialog(v-model='dialog' max-width='500px')
              template(v-slot:activator='{ on, attrs }')
                v-btn.mb-2(color='primary' dark v-bind='attrs' v-on='on')
                  v-icon.mr-3(left) mdi-plus
                  | Add Organization
              v-card.pa-4
                v-form(ref='form')
                  v-card-title
                    span.headline New Organization
                  v-card-text
                    v-container
                      v-row
                        v-col(cols="12")
                          v-text-field(v-model= 'newOrganization.org_name' label='Organization name')
                          v-text-field(v-model='newOrganization.org_type' label='Organization type')
                          v-text-field(v-model='newOrganization.inn' label='INN')
                          v-text-field(v-model='newOrganization.ogrn' label='OGRN')
                          v-select(v-model='newOrganization.clients' :items='clientEmails' :menu-props="{ maxHeight: '400' }" label='Select' multiple hint='Pick clients' persistent-hint)

                  v-card-actions
                    v-spacer
                    v-btn(color='blue darken-1' text @click='close')
                      | Cancel
                    v-btn(color='blue darken-1' text @click='save')
                      | Save
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
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Organization name', value: 'org_name' },
        { text: 'Organization type', value: 'org_type', filterable: false },
        { text: 'INN', value: 'inn', filterable: false },
        { text: 'OGRN', value: 'ogrn', filterable: false },
      ],
      newOrganization: {
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
    clientEmails () {
      return this.clients.map(v => v.email)
    }
  },

  watch: {
    dialog (val) {
      val || this.close()
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

    save () {
      Object.assign(this.newOrganization.clients, this.clients.filter(c => this.newOrganization.clients.includes(c.email)))

      this.$api.organizations.create(this.newOrganization)
          .then(response => {
            this.organizations.push(response.data)
            this.close()
          })
    },

    close () {
      this.dialog = false
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
