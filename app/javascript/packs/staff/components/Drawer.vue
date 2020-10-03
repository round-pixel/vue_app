<template lang="pug">
  v-navigation-drawer(color='primary' dark app absolute permanent)
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
          { title: 'Organizations', icon: 'mdi-office-building-outline', link: '/s/organizations' }
        ],
      }
    },
  }
</script>
