<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table.elevation-1.pa-4.mt-4(:headers='headers' :items='equipments' :search='search' @click:row="pushToEquipment")
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
                          v-text-field(v-model='newEquipment.name' label='Equipment name')
                          v-text-field(v-model='newEquipment.type' label='Equipment type')
                          v-text-field(v-model='newEquipment.serial_number' label='Serial number')
                          v-select(
                            v-model='newEquipment.organization_id'
                            item-text="org_name"
                            item-value="id"
                            :items='organizations'
                            :menu-props="{ maxHeight: '400' }"
                            label='Select'
                          )
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
      equipments: [],
      organizations: [],
      valid: true,
      search: '',
      dialog: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Equipment name', value: 'name' },
        { text: 'Equipment type', value: 'type', filterable: false },
        { text: 'Serial number', value: 'serial_number', filterable: false },
      ],
      newEquipment: {
        name: '',
        type: '',
        serial_number: '',
        organization: {}
      },
    }
  },

  created() {
    this.fetchEquipments()
    this.fetchOrganizations()
  },

  watch: {
    dialog (val) {
      val || this.close()
    },
  },

  methods: {
    fetchEquipments () {
      this.loading = true
      setTimeout( () => {
        this.$api.equipments.index()
            .then(response => this.equipments = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 300)
    },

    fetchOrganizations () {
      this.$api.organizations.index()
          .then(response => this.organizations = response.data)
    },

    save () {
      this.$api.equipments.create(this.newEquipment)
          .then(response => {
            this.equipments.push(response.data)
            this.close()
          })
    },

    close () {
      this.dialog = false
    },

    pushToEquipment(row) {
      this.$router.push({ name: 'equipment', params: { id: row.id } })
    }
  },

  components: {
    Loading
  }
}
</script>
