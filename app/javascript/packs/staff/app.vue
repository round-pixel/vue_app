<template lang="pug">
  v-app
    drawer

    dashboard
      router-view

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
  components: {
    Dashboard,
    Navbar,
    Drawer,
    Footer,
  },
}
</script>
