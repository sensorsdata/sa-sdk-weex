/* global Vue */
import { init } from 'sa-sdk-weex'
import Router from 'vue-router'
// var sensors = require('sa-sdk-weex');
import sensors from 'sa-sdk-weex'
/* weex initialized here, please do not move this line */
const { router } = require('./router')
const App = require('@/index.vue')
Vue.use(Router)
/* eslint-disable no-new */
new Vue(Vue.util.extend({ el: '#root', router }, App))

Vue.prototype.$sensors = sensors;
sensors.useRouter(router)