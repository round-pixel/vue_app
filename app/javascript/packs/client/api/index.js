import axios from 'axios'
import Vue from 'vue'

const api = {
  current: () => axios.get('/clients/current'),
  sign_out: () => axios.get('/clients/sign_out'),
  organizations: {
    index: () => axios.get('/clients/organizations'),
  }
}

Vue.prototype.$api = api