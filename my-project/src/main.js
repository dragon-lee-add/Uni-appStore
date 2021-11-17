import Vue from 'vue'
import uView from "uview-ui";
Vue.use(uView);

import App from './App'

import axios from 'axios'; /* 引入axios进行地址访问*/
Vue.prototype.$http = axios;//引入vuex
import store from './store'
//把vuex定义成全局组件
Vue.prototype.$store = store
Vue.config.productionTip = false


App.mpType = 'app'

const app = new Vue({
  ...App
})
app.$mount()
