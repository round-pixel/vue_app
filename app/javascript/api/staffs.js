import axios from 'axios'
import Vue from 'vue'

const api = {
  current: () => axios.get('current'),
  sign_out: () => axios.get('sign_out'),
  clients: {
    index: () => axios.get('clients'),
    create: (params) => axios.post('clients', params),
    update: (params) => axios.put(`clients/${params.id}`, params),
    destroy: (params) => axios.delete(`clients/${params.id}`, params)
  },
  organizations: {
    index: () => axios.get('organizations'),
    create: (params) => axios.post('organizations', params),
    update: (params) => axios.put(`organizations/${params.id}`, params),
    destroy: (params) => axios.delete(`organizations/${params.id}`, params)
  }
}

Vue.prototype.$api = api