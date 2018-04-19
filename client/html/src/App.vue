<template>
  <div>
    <transition name="slide">
      <div class="phone_wrapper" v-if="show" :style="{ backgroundImage: `url('${skinImg}')`, zoom: zoomFactor }">
        <div class="phone_screen" :style="skinPositions">
          <router-view></router-view>
        </div>
      </div>
    </transition>
    <div class="backdrop" @click="closePhone"></div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  export default {
    name: 'app',
    computed: {
      ...mapState(['show', 'zoomFactor', 'skin']),

      skinImg () {
        return require(`./assets/img/coque/${this.skin.data.filename}`)
      },

      skinPositions () {
        return this.skin.data.styles
      }
    },

    methods: {
      closePhone () {
        this.$http.post('http://gcphone/closePhone', JSON.stringify({}))
          .then(() => this.$store.commit('setShow', false))
      }
    },

    created () {
      window.addEventListener('message', (event) => {
        if (event.data.type === 'toggleUI') {
          this.$router.push({path: '/'})
          this.$store.commit('setShow', event.data.enable)
        }
        if (event.data.type === 'updateMessages') {
          this.$store.commit('setMessages', event.data.messages)
        }
        if (event.data.type === 'updateContacts') {
          console.log(event.data.contacts)
          this.$store.commit('setContacts', event.data.contacts)
        }
        if (event.data.type === 'updateYyPhoneNumber') {
          this.$store.commit('setMyPhoneNumber', event.data.phoneNumber)
        }
      })
    }
  }
</script>

<style lang="scss">
  $fa-font-path: "~font-awesome/fonts";
  @import "~font-awesome/scss/font-awesome.scss";

  * {
    user-select: none;
    outline: none;
    font-family: 'Roboto', sans-serif;
    box-sizing: border-box;

    &::-webkit-scrollbar-track {
      box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
      background-color: #F5F5F5;
    }

    &::-webkit-scrollbar {
      width: 3px;
      background-color: transparent;
    }

    &::-webkit-scrollbar-thumb {
      background-color: #666;
    }
  }

  body {
    overflow: hidden;
  }

  .backdrop {
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    position: fixed;
    background-color: transparent;
  }

  .phone_wrapper {
    position: absolute;
    bottom: 2vh;
    right: 2vh;
    width: 266px;
    height: 500px;
    z-index: 2;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;

    .phone_screen {
      overflow: hidden;
      position: absolute;
      background-color: white;
    }
  }

  .slide-enter-active, .slide-leave-active {
    transition: transform .35s ease, opacity .35s ease;
  }

  .slide-enter, .slide-leave-to {
    transform: translateY(60%);
    opacity: 0;
  }
</style>
