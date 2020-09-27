import Vue from 'vue'
import vuetify from 'configs/plugins/vuetify'

import 'api/staffs'
import App from 'packs/staff/app'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log('App mounted')
})