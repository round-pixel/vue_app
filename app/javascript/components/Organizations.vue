<template lang="pug">
  div
    template(v-if="loading")
      loading
    template(v-else-if="error")
      p Error :(
    template(v-else)
      // Form
      v-row(justify='center')
        v-dialog(v-model='dialog' persistent='' max-width='600px')
          template(v-slot:activator='{ on, attrs }')
            v-btn.ma-2(dark color='primary' v-bind='attrs' v-on='on')
              v-icon.mr-3(left) mdi-plus
              | Add Organization
          v-card.pa-16
            v-form(ref="form" @submit.prevent="createOrganization" v-model="valid" lazy-validation)
              v-card-title
                span.headline Organization Profile
              v-card-text
                v-container
                    v-row
                      v-col(cols="12")
                        v-text-field(v-model= 'org_name' label='Organization name')
                        v-text-field(v-model='org_type' label='Organization type')
                        v-text-field(v-model='inn' label='INN')
                        v-text-field(v-model='ogrn' label='OGRN')
                small *indicates required field
              v-card-actions
                v-spacer
                v-btn(color='blue darken-1' text='' @click='dialog = false')
                  | Close
                v-btn(color='blue darken-1' text=''  @click='validate()' type="submit")
                  | Save

      // Table
      v-simple-table.mt-8(height='300px')
        template(v-slot:default='')
          thead
            tr
              th.text-left Id
              th.text-left Organization name
              th.text-left Organization type
              th.text-left INN
              th.text-left OGRN
          tbody
            tr(v-for='organization in organizations' :key='organization.name')
              td {{ organization.id }}
              td {{ organization.org_name }}
              td {{ organization.org_type }}
              td {{ organization.inn }}
              td {{ organization.ogrn }}
</template>

<script>
import Loading from 'components/Loading'

export default {
  components: {Loading},
  data () {
    return {
      showForm: false,
      loading: true,
      error: false,
      dialog: false,
      organizations: [],

      org_name: '',
      org_type: '',
      inn: '',
      ogrn: '',
      valid: true,
    }
  },
  created() {
    this.fetchOrganizations()
  },
  methods: {
    fetchOrganizations () {
      this.loading = true
      setTimeout( () => {
        this.$api.organizations.index()
            .then(response => this.organizations = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
      }, 1000)
    },

    createOrganization() {
      console.log('created')
      const params = {
        org_name: this.org_name,
        org_type: this.org_type,
        inn: this.inn,
        ogrn: this.ogrn,
      }

      this.$api.organizations.create(params)
          .then(response => {
            this.organizations.push(response.data)
            this.clearForm()
          })
          .catch(e => console.log(e.response.data))
    },

    clearForm() {
      this.showForm = false
      this.org_name = ''
      this.org_type = ''
      this.inn = ''
      this.ogrn = ''
      this.valid = true
    },

    validate () {
      this.$refs.form.validate()
      this.valid && (this.dialog = false)
    },
    components: {
      Loading
    }
  }
}
</script>
