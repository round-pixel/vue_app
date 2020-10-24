import axios from 'axios'
import Vue from 'vue'

const adapter = axios.create({
  baseURL: '/s',
  headers: {
    'Accept': 'application/json'
  }
})

const api = {
  current: () => adapter.get('/current'),
  sign_out: () => axios.get('/staffs/sign_out'),
  reset_password: (params) => axios.put('/clients/password', params),
  clients: {
    index: () => adapter.get('/clients'),
    show: (params) => adapter.get(`/clients/${params.id}`),
    create: (params) => adapter.post('/clients', params),
    update: (params) => adapter.put(`/clients/${params.id}`, params),
    destroy: (params) => adapter.delete(`/clients/${params.id}`, params),
  },
  organizations: {
    index: (params) => adapter.get('/organizations', { params }),
    show: (params) => adapter.get(`/organizations/${params.id}`),
    create: (params) => adapter.post('/organizations', params),
    update: (params) => adapter.put(`/organizations/${params.id}`, params),
    destroy: (params) => adapter.delete(`/organizations/${params.id}`, params)
  },
  equipments: {
    index: (params) => adapter.get('/equipments', { params }),
    show: (params) => adapter.get(`/equipments/${params.id}`),
    create: (params) => adapter.post('/equipments', params),
    // update: (params) => adapter.put(`/equipments/${params.id}`, params),
    destroy: (params) => adapter.delete(`/equipments/${params.id}`, params)
  }
}

Vue.prototype.$api = api