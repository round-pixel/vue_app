import Vue from 'vue'
import vuetify from 'configs/plugins/vuetify'

import 'api/clients'
import App from 'packs/client/app'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log('App mounted')
})