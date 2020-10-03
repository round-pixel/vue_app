import axios from 'axios'
import Vue from 'vue'

const adapter = axios.create({
  headers: {
    'Accept': 'application/json'
  }
})

const api = {
  current: () => adapter.get('c/current'),
  sign_out: () => adapter.get('/clients/sign_out'),
  organizations: {
    index: () => adapter.get('/c/organizations'),
  }
}

Vue.prototype.$api = api