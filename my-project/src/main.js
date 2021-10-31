import Vue from 'vue'
import uView from "uview-ui";
Vue.use(uView);

import App from './App'


import axios from 'axios'; /* 引入axios进行地址访问*/
Vue.prototype.$http = axios;

Vue.config.productionTip = false


App.mpType = 'app'

const app = new Vue({
  ...App
})
app.$mount()
