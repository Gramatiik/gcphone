<template>
  <span>{{ time }}</span>
</template>

<script>
  export default {
    data () {
      return {
        time: '',
        updateInterval: null
      }
    },

    methods: {
      updateTime () {
        this.time = new Date().toTimeString().replace(/.*(\d{2}:\d{2}:\d{2}).*/, '$1')
      }
    },

    created () {
      this.updateTime()
      this.updateInterval = setInterval(this.updateTime, 1000)
    },

    beforeDestroy () {
      clearInterval(this.updateInterval)
    }
  }
</script>
