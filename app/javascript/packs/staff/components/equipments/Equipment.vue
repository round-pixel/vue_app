<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-card
        v-card-title
          .text-h3 {{ equipment.name }}
        v-card-text
          template(v-if="equipment.organization")
            .text-h3 Organization info
            .text-h6 Org name: {{ equipment.organization.org_name }}
            .text-h6 Org type: {{ equipment.organization.org_type }}
            .text-h6 Inn: {{ equipment.organization.inn }}
            .text-h6 OGRN: {{ equipment.organization.ogrn }}
  </template>

<script>
import Loading from 'components/Loading'

export default {
  data () {
    return {
      loading: true,
      error: false,
      client: {},
    }
  },

  created() {
    this.fetchEquipment()
  },

  methods: {
    fetchEquipment() {
      this.loading = true

      setTimeout( () => {
        this.$api.equipments.show(this.$route.params)
            .then(response => this.equipment = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 200)
    }
  },

  components: {
    Loading,
  }
}
</script>
