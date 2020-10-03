<template lang="pug">
  v-app
    // Drawer
    drawer(:selectTable="selectTable")

    // Navbar
    navbar

    // Dashboard
    dashboard
      component(:is="currentTable")

    // Footer
    footer
</template>

<script>
import Navbar from 'components/Navbar'
import Dashboard from 'components/Dashboard'
import Footer from 'components/Footer'
import Drawer from 'staff/components/Drawer'
import Clients from 'staff/components/Clients'
import Organizations from 'staff/components/Organizations'

export default {
  data () {
    return {
      currentTable: 'organizations'
    }
  },
  components: {
    Dashboard,
    Navbar,
    Drawer,
    Footer,
    Clients,
    Organizations
  },
  methods: {
    selectTable(name) {
      this.currentTable = name.toLowerCase()
      console.log(this.currentTable)
    }
  }
}
</script>
