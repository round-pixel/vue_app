<template lang="pug">
  v-app
    // Navbar
    navbar

    dashboard
      organizations

    // Footer
    footer
</template>

<script>
import Navbar from 'components/Navbar'
import Dashboard from 'components/Dashboard'
import Footer from 'components/Footer'
import Organizations from 'client/components/Organizations'

export default {
  components: {
    Navbar,
    Dashboard,
    Organizations,
    Footer,
  }
}
</script>
