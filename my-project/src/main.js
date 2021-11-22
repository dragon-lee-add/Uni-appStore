import Vue from 'vue'

import uView from "uview-ui";
import App from './App'
import axios from 'axios'; /* 引入axios进行地址访问*/
import store from './store'
import './router/index';//引入拦截
Vue.use(uView);


Vue.prototype.$http = axios;//引入vuex
//把vuex定义成全局组件
Vue.prototype.$store = store
Vue.config.productionTip = false

App.mpType = 'app'


const app = new Vue({
  ...App
})

app.$mount()
