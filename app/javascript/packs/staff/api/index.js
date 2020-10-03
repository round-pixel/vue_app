import axios from 'axios'
import Vue from 'vue'

const adapter = axios.create({
  headers: {
    'Accept': 'application/json'
  }
})

const api = {
  current: () => adapter.get('current'),
  sign_out: () => adapter.get('/staffs/sign_out'),
  clients: {
    index: () => adapter.get('clients'),
    create: (params) => adapter.post('clients', params),
    update: (params) => adapter.put(`clients/${params.id}`, params),
    destroy: (params) => adapter.delete(`clients/${params.id}`, params)
  },
  organizations: {
    index: () => adapter.get('organizations'),
    create: (params) => adapter.post('organizations', params),
    update: (params) => adapter.put(`organizations/${params.id}`, params),
    destroy: (params) => adapter.delete(`organizations/${params.id}`, params)
  }
}

Vue.prototype.$api = api