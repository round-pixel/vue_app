import axios from 'axios'
import Vue from 'vue'

const api = {
  current: () => axios.get('current'),
  sign_out: () => axios.get('sign_out')
}

Vue.prototype.$api = api