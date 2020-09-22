import axios from 'axios'
import Vue from 'vue'

const api = {
  current: () => axios.get('current'),
  sign_out: () => axios.get('sign_out'),
  clients: {
    index: () => axios.get('clients'),
    create: (params) => axios.post('clients', params)
  }
}

Vue.prototype.$api = api