import regexps from 'regexps'

const { phoneRegexp, emailRegexp, passwordRegexp } = regexps

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
  ],
  passwordRules: [
    v => !!v || 'Password is required',
    v => (v && v.length >= 8) || 'Password must be greater than 8 characters',
    v => (v && passwordRegexp.test(v)) || 'Password shoud be valid',
  ],
}

export default validationRules