<template>
  <div class="home" :style="{ backgroundImage: `url(${backgroundImg})` }">
    <span class="clock">
      <current-time></current-time>
    </span>
    <div class='apps'>
      <div
        class="apps__item"
        v-for="app of apps"
        :key="app.title"
        :style="{ backgroundImage: `url(${app.img})` }"
        @click="$router.push({path: app.urlPath})"
      >
          {{ app.title }}
          <span
            class="puce"
            v-if="app.puce !== undefined && app.puce !== 0"
          >{{ app.puce }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import CurrentTime from './CurrentTime'
import { mapState, mapGetters } from 'vuex'

export default {
  components: { CurrentTime },
  data () {
    return {
      apps: [{
        title: 'Contacts',
        img: require('../assets/img/contacts.png'),
        urlPath: 'contacts'
      }, {
        title: 'Messages',
        img: require('../assets/img/sms.png'),
        urlPath: 'messages',
        puce: this.getUnreadMessagesCount
      }, {
        title: 'Téléphone',
        img: require('../assets/img/call.png'),
        urlPath: 'phone'
      }, {
        title: 'Paramètres',
        img: require('../assets/img/settings.png'),
        urlPath: 'settings'
      }]
    }
  },
  computed: {
    ...mapState(['wallpaper']),
    ...mapGetters(['getUnreadMessagesCount']),
    backgroundImg () {
      return require(`../assets/img/${this.wallpaper.filename}`)
    }
  }
}
</script>

<style lang="scss" scoped>
  .home {
    background-size: cover !important;
    background-position: center;
    position: relative;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    display: flex;
    align-content: center;
    justify-content: center;

    .clock {
      font-size: 48px;
      margin-top: 80px;
      color: white;
      text-shadow: -1px 0 0 rgba(0,0,0, 0.8), 1px 0 0 rgba(0,0,0, 0.8), 0 -1px 0 rgba(0,0,0, 0.8), 0 1px 0 rgba(0,0,0, 0.8);
    }

    .apps {
      display: flex;
      width: 100%;
      position: absolute;
      bottom: 0;
      margin-bottom: 12px;
      align-items: flex-end;
      flex-flow: row;
      flex-wrap: wrap;
      justify-content: space-between;

      &__item {
        position: relative;
        width: 64px;
        height: 72px;
        margin: 2px;
        padding-top: 52px;
        color: white;
        font-weight: 700;
        text-align: center;
        border-radius: 12px;
        font-size: 10px;
        background-size: 48px 48px;
        background-position: 6px 6px;
        background-repeat: no-repeat;
        background-color: transparent;
        text-shadow: -1px 0 0 rgba(0,0,0, 0.8), 1px 0 0 rgba(0,0,0, 0.8), 0 -1px 0 rgba(0,0,0, 0.8), 0 1px 0 rgba(0,0,0, 0.8);
        transition: background-color .1s ease-in-out;

        &:hover {
          background-color: rgba(255,255,255, 0.7);
        }

        &.puce {
          position: absolute;
          display: block;
          background-color: darkorange;
          width: 16px;
          height: 16px;
          line-height: 14px;
          text-align: center;
          border-radius: 50%;
          border: 1px solid white;
          top: 38px;
          left: 38px;
        }
      }
    }
  }
</style>
