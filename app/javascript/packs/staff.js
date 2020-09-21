import Vue from 'vue'
import vuetify from 'common_configs/plugins/vuetify'

import 'staff/api'
import App from 'staff/app'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log('App mounted')
})