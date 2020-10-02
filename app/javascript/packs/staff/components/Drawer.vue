<template lang="pug">
  v-navigation-drawer(color='primary' dark app absolute permanent)
    v-list
      v-list-item(v-for='item in items' :key='item.title' link='' @click="selectTable(item.title)")
        v-list-item-icon
          v-icon {{ item.icon }}
        v-list-item-content
          v-list-item-title {{ item.title }}
</template>

<script>
  export default {
    props: {
      selectTable: {
        type: Function
      }
    },
    data () {
      return {
        items: [
          { title: 'Clients', icon: 'mdi-account-supervisor' },
          { title: 'Organizations', icon: 'mdi-office-building-outline' }
        ],
      }
    },
  }
</script>
