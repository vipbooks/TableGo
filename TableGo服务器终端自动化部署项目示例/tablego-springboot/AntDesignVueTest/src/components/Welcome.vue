<template>
    <div>
        <img alt="Vue logo" src="../assets/logo.png">
        <h1>Welcome to Your Vue.js App</h1>

        <div class="test">
            <router-link to="/buttonTest">Button组件测试</router-link>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'Welcome'
    }
</script>

<style>
    .test {
        font-size: 20px;
    }
</style>
