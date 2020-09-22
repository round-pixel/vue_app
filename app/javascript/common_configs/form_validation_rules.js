import regexps from 'common_configs/regexps'

const { phoneRegexp, emailRegexp } = regexps

const validationRules = {
  fullnameRules: [
    v => !!v || 'Full name is required',
    v => (v && v.length >= 5) || 'Full name must be less than 5 characters',
  ],
  phoneRules: [
    v => !!v || 'Phone is required',
    v => (v && phoneRegexp.test(v)) || 'Phone must be only digits',
  ],
  emailRules: [
    v => !!v || 'Email is required',
    v => (v && emailRegexp.test(v)) || 'Email shoud be valid',
  ]
}

export default validationRules