<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      .text-h2.mb-8 {{ organization.org_name }}

      v-card(flat="")
        v-tabs(v-model='tab')
          v-tab(v-for='item in items' :key='item.tab')
            | {{ item.tab }}
        v-tabs-items.pa-4(v-model='tab')
          v-tab-item(v-for='item in items' :key='item.tab')
            component(:is="item.component" :organization="organization")


</template>

<script>
import Loading from 'components/Loading'
import Equipments from 'staff/components/organizations/Equipments'
import Clients from 'staff/components/organizations/Clients'

export default {
  data () {
    return {
      loading: true,
      error: false,
      organization: {},

      tab: 0,
      items: [
        { tab: 'Equipments', component: Equipments },
        { tab: 'Clients', component: Clients },
      ],
    }
  },

  created() {
    this.fetchOrganization()
  },

  methods: {
    fetchOrganization() {
      this.loading = true

      setTimeout( () => {
        this.$api.organizations.show(this.$route.params)
            .then(response => this.organization = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 200)
    }
  },

  components: {
    Loading,
    Equipments,
    Clients,
  }
}
</script>
