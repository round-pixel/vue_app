<template lang="pug">
  v-app
    // Navbar
    navbar

    organizations

    // Footer
    v-footer(app='')
      p Footer
</template>

<script>
import Navbar from 'components/Navbar'
import Organizations from 'client/components/Organizations'

export default {
  components: {
    Organizations,
    Navbar,
    Dashboard
  }
}
</script>
