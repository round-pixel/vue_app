<template lang="pug">
  div
    v-data-table.elevation-1(:headers='headers' :items='currentOrganization.clients')
</template>

<script>
export default {
  props: [
    'organization'
  ],
  data () {
    return {
      currentOrganization: this.organization,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Full name', value: 'full_name' },
        { text: 'Email', value: 'email' },
        { text: 'Phone', value: 'phone' },
      ],
    }
  },
}
</script>
