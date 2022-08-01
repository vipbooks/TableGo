<template>
    <div>
        <a-space size="middle">
            <a-button @click="btnTest">默认类型</a-button>
            <a-button type="primary">Primary类型</a-button>
            <a-button type="dashed">Dashed类型</a-button>
            <a-button type="danger">Danger类型</a-button>
        </a-space>
    </div>
</template>

<script>
    export default {
        name: "Button组件测试",
        methods: {
            btnTest() {
                alert("测试按键")
            }
        }
    }
</script>

<style scoped>

</style>