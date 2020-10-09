<template lang="pug">
  v-data-table.elevation-1(:headers='headers' :items='client.organizations' :search='search')
    template(v-slot:top='')
      v-toolbar(flat='')
        v-toolbar-title Organizations
        v-spacer
        v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line='' hide-details='')
        v-spacer
        v-dialog(v-model='dialogDelete' max-width='500px')
          v-card
            v-card-title.headline Are you sure you want to delete this organization?
            v-card-actions
              v-spacer
              v-btn(color='blue darken-1' text='' @click='closeDelete') Cancel
              v-btn(color='blue darken-1' text='' @click='deleteItemConfirm') OK
              v-spacer
    template(v-slot:item.actions='{ item }')
      v-icon(small='' @click='deleteItem(item)')
        | mdi-delete

</template>

<script>

  export default {
    props: ['client'],

    data () {
      return {
        search: '',
        dialog: false,
        dialogDelete: false,
        deleteOrganization: null,
        deleteOrganizationIndex: -1,
        headers: [
          { text: 'Id', value: 'id', filterable: false,},
          { text: 'Organization name', value: 'org_name' },
          { text: 'Organization type', value: 'org_type', filterable: false },
          { text: 'INN', value: 'inn', filterable: false },
          { text: 'OGRN', value: 'ogrn', filterable: false },
          { text: 'Actions', value: 'actions', sortable: false },
        ],
      }
    },
    methods: {
      deleteItem (item) {
        this.dialogDelete = true
        this.deleteOrganization = item.id
        this.deleteOrganizationIndex = client.organizations.index(item)
      },

      deleteItemConfirm () {
        this.$route.params.organization_id = this.deleteOrganization

        this.$api.clients.destroy_organization(this.$route.params)
            .then(response => {
              this.client.organizations.splice(this.deleteOrganizationIndex, 1)
              this.closeDelete()
            })
      },

      closeDelete () {
        this.dialogDelete = false
        this.deleteOrganizationIndex = -1
      },
    }
  }
</script>
