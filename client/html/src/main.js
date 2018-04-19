// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import VueTimeago from 'vue-timeago'
import VueResource from 'vue-resource'

Vue.use(VueResource)

Vue.use(VueTimeago, {
  name: 'timeago',
  locale: 'fr-FR',
  locales: { 'fr-FR': require('vue-timeago/locales/fr-FR.json') }
})

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
