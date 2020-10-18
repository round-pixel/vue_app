<template lang="pug">
  v-navigation-drawer(color='primary' dark app absolute permanent)
    template(v-slot:prepend='')
      v-list-item(two-line='')
        v-list-item-avatar
          img(src='https://randomuser.me/api/portraits/men/81.jpg')
        v-list-item-content
          v-list-item-title {{ user.full_name }}
          v-list-item-subtitle {{ user.email }}
        v-btn(icon='')
          v-icon(@click="sign_out") mdi-exit-to-app
    v-divider

    v-list
      v-list-item(v-for='item in items' :key='item.title' @click="$router.push({ path: item.link })")
        v-list-item-icon
          v-icon {{ item.icon }}
        v-list-item-content
          v-list-item-title {{ item.title }}
</template>

<script>
  export default {
    data () {
      return {
        items: [
          { title: 'Clients', icon: 'mdi-account-supervisor', link: '/s/clients' },
          { title: 'Organizations', icon: 'mdi-office-building-outline', link: '/s/organizations' },
          { title: 'Equipments', icon: 'mdi-tools', link: '/s/equipments' },
        ],

        user: {}
      }
    },

    created() {
      this.fetchUser()
    },

    methods: {
      fetchUser () {
        this.$api.current()
            .then(response => this.user = response.data)
      },

      sign_out() {
        this.$api.sign_out()
            .then(() => location.reload())
      }
    }
  }
</script>
