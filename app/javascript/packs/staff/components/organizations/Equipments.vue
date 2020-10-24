<template lang="pug">
  v-data-table.elevation-1.pa-4.mt-4(:headers='headers' :items='currentOrganization.equipments' :search='search')
    template(v-slot:top)
      v-toolbar(flat)
        v-toolbar-title Equipments
        v-spacer
        v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line hide-details)
        v-spacer
        v-dialog(v-model='dialog' max-width='500px')
          template(v-slot:activator='{ on, attrs }')
            v-btn.mb-2(color='primary' dark v-bind='attrs' v-on='on')
              v-icon.mr-3(left) mdi-plus
              | Add Equipment
          v-card.pa-4
            v-form(ref='form')
              v-card-title
                span.headline New Equipment
              v-card-text
                v-container
                  v-row
                    v-col(cols="12")
                      v-text-field(v-model= 'newEquipment.name' label='Equipment name')
                      v-text-field(v-model='newEquipment.type' label='Equipment type')
                      v-text-field(v-model='newEquipment.serial_number' label='Serial number')
              v-card-actions
                v-spacer
                v-btn(color='blue darken-1' text @click='close')
                  | Cancel
                v-btn(color='blue darken-1' text @click='save')
                  | Save

    template(v-slot:item.actions='{ item }')
      v-icon(small @click='deleteEquipment(item)')
        | mdi-delete

</template>

<script>

export default {
  props: [
    'organization'
  ],
  data () {
    return {
      currentOrganization: this.organization,
      organizations: [],
      equipments: [],
      valid: true,
      search: '',
      dialog: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Equipment name', value: 'name' },
        { text: 'Equipment type', value: 'type', filterable: false },
        { text: 'Serial Number', value: 'serial_number', filterable: false },
        { text: 'Actions', value: 'actions', sortable: false },
      ],
      newEquipment: {
        name: '',
        type: '',
        serial_number: '',
      },
    }
  },

  watch: {
    dialog (val) {
      val || this.close()
    },
  },

  methods: {
    save () {
      this.newEquipment.organization_id = this.currentOrganization.id

      this.$api.equipments.create(this.newEquipment)
          .then(response => {
            this.currentOrganization.equipments.push(response.data)
            this.close()
          })
    },

    close () {
      this.dialog = false
    },

    deleteEquipment (item) {
      const params = { id: item.id }

      this.$api.equipments.destroy(params)
          .then(() => this.currentOrganization.equipments.splice(this.currentOrganization.equipments.indexOf(item), 1))
    },

  },
}
</script>
