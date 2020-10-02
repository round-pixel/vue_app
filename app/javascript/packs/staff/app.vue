<template lang="pug">
  v-app
    // Drawer
    drawer(:selectTable="selectTable")

    // Navbar
    navbar

    // Dashboard
    dashboard(:currentTable="currentTable")

    // Footer
    // footer
</template>

<script>
import Navbar from 'components/Navbar'
import Dashboard from 'components/Dashboard'
import Drawer from 'components/Drawer'
import Footer from 'components/Footer'

export default {
  data () {
    return {
      currentTable: 'clients'
    }
  },
  components: {
    Dashboard,
    Navbar,
    Drawer,
    Footer,
  },
  methods: {
    selectTable(name) {
      this.currentTable = name.toLowerCase()
      console.log(this.currentTable)
    }
  }
}
</script>
