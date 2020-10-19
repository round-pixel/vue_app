import Vue from 'vue'
import VueRouter from 'vue-router'

import Organizations from 'staff/components/organizations/Organizations'
import Organization from 'staff/components/organizations/Organization'
import Clients from 'staff/components/clients/Clients'
import Client from 'staff/components/clients/Client'
import Equipments from 'staff/components/equipments/Equipments'
import Equipment from 'staff/components/equipments/Equipment'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/staffs/dashboard', redirect: '/s/clients' },

    { path: '/s/clients', component: Clients, name: 'clients' },
    { path: '/s/clients/:id', component: Client, name: 'client' },
    { path: '/s/organizations', component: Organizations, name: 'organizations' },
    { path: '/s/organizations/:id', component: Organization, name: 'organization' },
    { path: '/s/equipments', component: Equipments, name: 'equipments' },
    { path: '/s/equipments/:id', component: Equipment, name: 'equipment' },
  ]
})

export default router