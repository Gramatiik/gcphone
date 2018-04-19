import Vue from 'vue'
import Vuex from 'vuex'

import initialState from './initialState'
import mutations from './mutations'
import getters from './getters'

Vue.use(Vuex)

export default new Vuex.Store({
  state: initialState(),
  mutations,
  getters
})
