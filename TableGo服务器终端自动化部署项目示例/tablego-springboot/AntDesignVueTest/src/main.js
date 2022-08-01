import Vue from 'vue'
import App from './App.vue'
import router from './router/index'

import {Button, Space} from 'ant-design-vue'

Vue.use(Button)
Vue.use(Space)

Vue.config.productionTip = false

new Vue({
    render: h => h(App),
    router
}).$mount('#app')
