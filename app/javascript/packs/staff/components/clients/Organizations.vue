<template lang="pug">
  v-data-table.elevation-1(:headers='headers' :items='currentClient.organizations' :search='search')
    template(v-slot:top='')
      v-toolbar(flat='')
        v-toolbar-title Organizations
        v-spacer
        v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line='' hide-details='')
        v-spacer
        v-dialog(v-model='dialog' max-width='500px')
          template(v-slot:activator='{ on, attrs }')
            v-btn.mb-2(color='primary' dark='' v-bind='attrs' v-on='on' @click="fetchOrganizations")
              v-icon.mr-3(left) mdi-plus
              | Add Organization
          v-card.pa-8
            v-select(
              v-model='selectedOrganizations'
              :items='newOrganizationsNames'
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

    template(v-slot:item.actions='{ item }')
      v-icon(small='' @click='deleteOrganization(item)')
        | mdi-delete
</template>

<script>

export default {
  props: [
    'client'
  ],
  data () {
    return {
      valid: true,
      search: '',
      dialog: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Organization name', value: 'org_name' },
        { text: 'Organization type', value: 'org_type', filterable: false },
        { text: 'INN', value: 'inn', filterable: false },
        { text: 'OGRN', value: 'ogrn', filterable: false },
        { text: 'Actions', value: 'actions', sortable: false },
      ],
      currentClient: this.client,
      newOrganizations: [],
      selectedOrganizations: [],
    }
  },

  computed: {
    newOrganizationsNames () {
      return this.newOrganizations.map(v => v.org_name)
    }
  },

  methods: {
    fetchOrganizations () {
      const params = {
        client_id: this.client.id,
        status: 'created'
      }

      this.$api.organizations.index(params)
          .then(response => this.newOrganizations = response.data)
    },

    save () {
      Object.assign(this.currentClient.organizations,
          this.currentClient.organizations.concat(
              this.newOrganizations.filter(o => this.selectedOrganizations.includes(o.org_name)
      )))

      this.$api.clients.update(this.currentClient)
          .then(response => {
            this.currentClient = response.data
            this.close()
          })
    },

    close () {
      this.dialog = false
    },

    deleteOrganization (item) {
      this.$api.clients.update(this.currentClient)
        .then(() => this.currentClient.organizations.splice(this.currentClient.organizations.indexOf(item), 1))
    },

  },
}
</script>
