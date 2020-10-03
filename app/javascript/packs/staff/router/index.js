import Vue from 'vue'
import VueRouter from 'vue-router'

import Organizations from 'staff/components/Organizations'
import Organization from 'staff/components/Organization'
import Clients from 'staff/components/Clients'
import Client from 'staff/components/Client'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/staffs/dashboard', redirect: '/s/clients' },
    { path: '/s/clients', component: Clients, name: 'clients' },
    { path: '/s/clients/:id', component: Client, name: 'client' },
    { path: '/s/organizations', component: Organizations, name: 'organizations' },
    { path: '/s/organizations/:id', component: Organization, name: 'organization' }
  ]
})

export default router