<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      .text-h2.mb-8 {{ client.full_name }}

      v-card(flat="")
        v-tabs(v-model='tab')
          v-tab(v-for='item in items' :key='item.tab')
            | {{ item.tab }}
        v-tabs-items.pa-4(v-model='tab')
          v-tab-item(v-for='item in items' :key='item.tab')
            component(:is="item.component" :client="client")


</template>

<script>
import Loading from 'components/Loading'
import Organizations from 'staff/components/clients/Organizations'
import EditProfile from 'staff/components/clients/EditProfile'
import ResetPassword from 'staff/components/clients/ResetPassword'

export default {
    data () {
      return {
        loading: true,
        error: false,
        client: {},

        tab: 1,
        items: [
          { tab: 'Organizations', component: Organizations },
          { tab: 'Profile', component: EditProfile },
          { tab: 'Reset password', component: ResetPassword },
        ],
      }
    },

    created() {
      this.fetchClient()
    },

    methods: {
      fetchClient() {
        this.loading = true

        setTimeout( () => {
          this.$api.clients.show(this.$route.params)
              .then(response => this.client = response.data)
              .catch((e) => this.error = true)
              .finally(() => this.loading = false)
        }, 200)
      }
    },

    components: {
      Loading,
      Organizations,
      EditProfile,
      ResetPassword,
    }
  }
</script>
