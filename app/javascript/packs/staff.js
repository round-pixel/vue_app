import Vue from 'vue'
import vuetify from 'plugins/vuetify'

import 'staff/api'
import App from 'staff/app'
import router from 'staff/router'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    router,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log('App mounted')
})