<template lang="pug">
  v-main
    v-container
      template(v-if="loading")
        p Loading...
      template(v-else-if="error")
        p Error :(
      template(v-else)
        // Create client btn
        div(:class="showForm && 'd-none'")
          .d-flex.justify-end
            v-btn.ma-2(outlined='' color='pink' @click="showClientForm")
              v-icon.mr-3(left) mdi-account-plus
              | Add Client

        // Form
        div(:class="!showForm && 'd-none'")
          v-container
            v-row.justify-center
              v-col(cols-md='12' md='4')
                v-card.pa-10
                  .text-h4.text-center.mb-5 New client

                  v-form(ref="form" @submit.prevent="createClient" v-model="valid" lazy-validation)
                    v-text-field(v-model= 'fullname' label='Full name' :rules="fullnameRules")
                    v-text-field(v-model='email' label='E-mail' :rules="emailRules")
                    v-text-field(v-model='phone' label='Phone' :rules="phoneRules")

                    v-btn.mr-4(outlined color='pink' @click="validate()" type="sbmit" block)
                      | Submit

        // Table
        v-simple-table.mt-3(height='300px')
          template(v-slot:default='')
            thead
              tr
                th.text-left Id
                th.text-left Full Name
                th.text-left Email
                th.text-left Phone
            tbody
              tr(v-for='client in clients' :key='client.email')
                td {{ client.id }}
                td {{ client.full_name }}
                td {{ client.email }}
                td {{ client.phone }}

</template>

<script>
import validations from 'common_configs/form_validation_rules'
const { fullnameRules, phoneRules, emailRules } = validations

export default {
  data () {
    return {
      showForm: false,
      loading: true,
      error: false,
      clients: [],

      fullname: '',
      email: '',
      phone: '',
      valid: true,
      fullnameRules,
      phoneRules,
      emailRules
    }
  },
  created() {
    this.fetchClients()
  },
  methods: {
    fetchClients () {
      this.loading = true
      this.$api.clients.index()
          .then(response => this.clients = response.data)
          .catch((e) => this.error = true)
          .finally(() => this.loading = false)
    },

    createClient() {
      const params = {
        email: this.email,
        phone: this.phone,
        full_name: this.fullname
      }

      this.$api.clients.create(params)
          .then(response => {
            this.clients.push(response.data)
            this.clearForm()
          })
          .catch(e => console.log(e.response.data))
    },

    showClientForm() {
      this.showForm = true
    },

    clearForm() {
      this.showForm = false
      this.fullname = ''
      this.email = ''
      this.phone = ''
      this.valid = true
    },

    validate () {
      this.$refs.form.validate()
    },
  }
}
</script>
