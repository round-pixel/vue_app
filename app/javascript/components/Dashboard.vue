<template lang="pug">
  v-main
    v-container
      component(:is="currentTable")
</template>

<script>
  import Clients from 'components/Clients'
  import Organizations from 'components/Organizations'

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
