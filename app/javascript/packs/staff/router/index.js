import Vue from 'vue'
import VueRouter from 'vue-router'

import Organizations from 'staff/components/Organizations'
import Clients from 'staff/components/Clients'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/staffs/dashboard', redirect: '/s/clients' },
    { path: '/s/clients', component: Clients },
    { path: '/s/organizations', component: Organizations }
  ]
})

export default router