<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table.elevation-1.pa-4.mt-4(:headers='headers' :items='organizations' :search='search')
        template(v-slot:top)
          v-toolbar(flat)
            v-toolbar-title Organizations
            v-spacer
            v-text-field(v-model='search' append-icon='mdi-magnify' label='Search' single-line hide-details)
</template>

<script>
import Loading from 'components/Loading'

export default {
  data () {
    return {
      loading: true,
      error: false,
      organizations: [],
      search: '',
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Organization name', value: 'org_name' },
        { text: 'Organization type', value: 'org_type', filterable: false },
        { text: 'INN', value: 'inn', filterable: false },
        { text: 'OGRN', value: 'ogrn', filterable: false },
      ],
    }
  },

  created() {
    this.fetchOrganizations()
  },

  methods: {
    fetchOrganizations () {
      this.loading = true
      setTimeout( () => {
        this.$api.organizations.index()
            .then(response => this.organizations = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 200)
    },
  },

  components: {
    Loading
  }
}
</script>
