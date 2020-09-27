<template lang="pug">
  v-app
    // Navbar
    navbar

    // Dashboard
    //dashboard

    // Footer
    v-footer(app='')
      p Footer
</template>

<script>
import Navbar from 'components/Navbar'
import Dashboard from 'components/Dashboard'

export default {
  components: {
    Dashboard,
    Navbar
  }
}
</script>
