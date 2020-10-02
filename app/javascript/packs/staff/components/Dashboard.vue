<template lang="pug">
  v-main
    v-container
      component(:is="currentTable")
</template>

<script>
  import Clients from 'staff/components/Clients'
  import Organizations from 'staff/components/Organizations'

  export default {
    props: {
      currentTable: {
        type: String
      }
    },
    components: {
      Clients,
      Organizations
    }
  }
</script>
