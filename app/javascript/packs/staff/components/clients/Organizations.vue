<template lang="pug">
  v-data-table.elevation-1(:headers='headers' :items='client.organizations' :search='search')

</template>

<script>

  export default {
    props: ['client'],

    data () {
      return {
        search: '',
        headers: [
          { text: 'Id', value: 'id', filterable: false,},
          { text: 'Organization name', value: 'org_name' },
          { text: 'Organization type', value: 'org_type', filterable: false },
          { text: 'INN', value: 'inn', filterable: false },
          { text: 'OGRN', value: 'ogrn', filterable: false },
          { text: 'Actions', value: 'actions', sortable: false },
        ],
      }
    },
  }
</script>
