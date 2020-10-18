<template lang="pug">
  v-form(ref='form' lazy-validation='')
    v-col(md="6" xs="12")
      v-card(flat)
        v-alert(:value='alert.error' color='red' dark dense outlined text)
          | Error update profile
        v-alert(:value='alert.success' color='green' dark text)
          | Profile updated succesfully!
        v-card-text
          v-text-field(v-model= 'editedProfile.full_name' label='Full name' :rules="fullnameRules")
          v-text-field(v-model='editedProfile.email' label='E-mail' :rules="emailRules")
          v-text-field(v-model='editedProfile.phone' label='Phone' :rules="phoneRules")
        v-card-actions
          v-spacer
          v-btn(color='blue darken-1' text='' @click='updateProfile')
            | Update
</template>

<script>
  import validations from 'form_validation_rules'
  const { fullnameRules, phoneRules, emailRules } = validations

  export default {
    props: [
      'client'
    ],

    data() {
      return {
        alert: {
          error: false,
          success: false,
        },
        currentCLient: this.client,
        fullnameRules,
        phoneRules,
        emailRules,
        editedProfile: {
          full_name: '',
          email: '',
          phone: ''
        },
      }
    },

    mounted() {
      Object.assign(this.editedProfile, this.currentCLient)
    },

    methods: {
      updateProfile() {
        this.$api.clients.update(this.currentCLient)
          .then(() => {
            this.alert.success = true
            this.alert.error = false
            setTimeout(() => this.alert.success = false, 1000)
          })
          .catch(() => {
            Object.assign(this.editedProfile, this.currentCLient)
            this.alert.error = true
            this.alert.success = false
            setTimeout(() => this.alert.error = false, 1000)
          })
      }
    }

  }
</script>
