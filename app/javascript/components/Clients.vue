<template lang="pug">
  div
    template(v-if="loading")
      p Loading...
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-data-table(:headers='headers' :items='clients' sort-by='phone')
        template(v-slot:top='')
          v-toolbar(flat='')
            v-toolbar-title My CRUD
            v-divider.mx-4(inset='' vertical='')
            v-spacer
            v-dialog(v-model='dialog' max-width='500px')
              template(v-slot:activator='{ on, attrs }')
                v-btn.mb-2(color='primary' dark='' v-bind='attrs' v-on='on')
                  | New Item
              v-card
                v-card-title
                  span.headline {{ formTitle }}
                v-card-text
                  v-container
                    v-row
                      v-col(cols='12' sm='6' md='4')
                        v-text-field(v-model='editedItem.name' label='Dessert name')
                      v-col(cols='12' sm='6' md='4')
                        v-text-field(v-model='editedItem.calories' label='Calories')
                      v-col(cols='12' sm='6' md='4')
                        v-text-field(v-model='editedItem.fat' label='Fat (g)')
                      v-col(cols='12' sm='6' md='4')
                        v-text-field(v-model='editedItem.carbs' label='Carbs (g)')
                      v-col(cols='12' sm='6' md='4')
                        v-text-field(v-model='editedItem.protein' label='Protein (g)')
                v-card-actions
                  v-spacer
                  v-btn(color='blue darken-1' text='' @click='close')
                    | Cancel
                  v-btn(color='blue darken-1' text='' @click='save')
                    | Save
            v-dialog(v-model='dialogDelete' max-width='500px')
              v-card
                v-card-title.headline Are you sure you want to delete this item?
                v-card-actions
                  v-spacer
                  v-btn(color='blue darken-1' text='' @click='closeDelete') Cancel
                  v-btn(color='blue darken-1' text='' @click='deleteItemConfirm') OK
                  v-spacer
        template(v-slot:item.actions='{ item }')
          v-icon.mr-2(small='' @click='editItem(item)')
            | mdi-pencil
          v-icon(small='' @click='deleteItem(item)')
            | mdi-delete
        template(v-slot:no-data='')
          v-btn(color='primary' @click='initialize')
            | Reset
      // Form
      v-divider

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

</template>

<script>
import validations from 'configs/form_validation_rules'
const { fullnameRules, phoneRules, emailRules } = validations

export default {
  data () {
    return {
      // Api call
      loading: true,
      error: false,
      clients: [],

      // Validations
      fullname: '',
      email: '',
      phone: '',
      valid: true,
      fullnameRules,
      phoneRules,
      emailRules,

      // Table
      dialog: false,
      dialogDelete: false,
      headers: [
        { text: 'Id', value: 'id', filterable: false,},
        { text: 'Full name', value: 'fullname' },
        { text: 'Email', value: 'email', filterable: false },
        { text: 'Phone', value: 'phone', filterable: false },
      ],
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
