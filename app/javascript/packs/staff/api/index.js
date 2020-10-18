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
    destroy_organization: (params) => adapter.delete(
      `/clients/${params.id}/destroy_organization?organization_id=${params.organization_id}`
    ),
  },
  organizations: {
    index: (params) => adapter.get('/organizations', { params }),
    show: (params) => adapter.get(`/organizations/${params.id}`),
    create: (params) => adapter.post('/organizations', params),
    update: (params) => adapter.put(`/organizations/${params.id}`, params),
    destroy: (params) => adapter.delete(`/organizations/${params.id}`, params)
  }
}

Vue.prototype.$api = api