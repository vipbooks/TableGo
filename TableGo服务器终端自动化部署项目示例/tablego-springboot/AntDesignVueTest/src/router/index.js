/** 路由器模块 */

import Vue from 'vue'
import VueRouter from 'vue-router'
import Welcome from '../components/Welcome'
import ButtonTest from '../components/ButtonTest'

Vue.use(VueRouter)

// 对外暴露多个路由，映射路由组件
export default new VueRouter({
    routes: [
        {
            path: '/',  // 配置根路径，并重定向到默认路由
            redirect: '/welcome'
        },
        {
            path: '/welcome',
            component: Welcome
        },
        {
            path: '/buttonTest',
            component: ButtonTest
        }
    ]
})
