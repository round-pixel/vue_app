<template lang="pug">
  v-form(ref='form' lazy-validation='')
    v-col(md="6" xs="12")
      v-card(flat)
        v-alert(:value='alert.error' color='red' dark dense outlined text)
          | Error update password
        v-alert(:value='alert.success' color='green' dark text)
          | Password updated succesfully!
        v-card-text
          v-text-field(v-model= 'password' label='New pasword' :rules="passwordRules")
          v-text-field(v-model='password_confirmation' label='Pasword confirmation' :rules="passwordConfirmationRules")
        v-card-actions
          v-spacer
          v-btn(color='blue darken-1' text='' @click='updateProfile')
            | Update
</template>

<script>
import validations from 'form_validation_rules'
const { passwordRules } = validations

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
      passwordRules,
      passwordConfirmationRules: passwordRules.concat([
        v => (v === this.password) || 'Not equal to password'
      ]),
      password: '',
      password_confirmation: '',
    }
  },

  methods: {
    updateProfile() {
      this.$refs.form.validate()

      const params = {
        password: this.password,
        password_confirmation: this.password_confirmation,
        client_id: this.currentCLient.id
      }

      this.$api.reset_password(params)
          .then(() => {
            this.alert.success = true
            this.alert.error = false
            setTimeout(() => this.alert.success = false, 1000)
          })
          .catch(() => {
            this.alert.error = true
            this.alert.success = false
            setTimeout(() => this.alert.error = false, 1000)
          })
    }
  }

}
</script>
