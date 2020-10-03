import Vue from 'vue'
import vuetify from 'plugins/vuetify'

import 'client/api'
import App from 'client/app'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log('App mounted')
})