import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    message: 'Message from Vuex',
    organizations: {
      index: {}
    }
  },

  mutations: {
    CHANGE_MESSAGE: (state, payload) => state.message = payload || 'Changed message',
    FETCH_ORGANIZATIONS: (state, data) => state.organizations.index = data
  },

  actions: {
    fetchOrganizations: (ctx) => {
      Vue.prototype.$api.organizations.index()
        .then(response => ctx.commit('FETCH_ORGANIZATIONS'))
    }
  }
})

export default store