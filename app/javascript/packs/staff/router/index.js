import Vue from 'vue'
import VueRouter from 'vue-router'

import Organizations from 'staff/components/organizations/Organizations'
import Organization from 'staff/components/organizations/Organization'
import Clients from 'staff/components/clients/Clients'
import Client from 'staff/components/clients/Client'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/staffs/dashboard', redirect: '/s/organizations' },
    { path: '/s/clients', component: Clients, name: 'clients' },
    { path: '/s/clients/:id', component: Client, name: 'client' },
    { path: '/s/organizations', component: Organizations, name: 'organizations' },
    { path: '/s/organizations/:id', component: Organization, name: 'organization' }
  ]
})

export default router