<template lang="pug">
  v-app
    // Drawer
    // v-navigation-drawer(app='')

    // Navbar
    navbar

    // Dashboard
    dashboard

    // Footer
    v-footer(app='')
      p Footer
</template>

<script>
import navbar from 'staff/components/navbar'
import dashboard from 'staff/components/dashboard'

export default {
  components: {
    dashboard,
    navbar
  }
}
</script>
