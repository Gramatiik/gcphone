<template>
  <div class="screen">
    <div class='title'>
      <i
        class="back-button fa fa-long-arrow-left"
        @click="back"
      ></i>
      Paramètres
    </div>
    <div class='elements'>
      <div class="element">
        <i class="fa fa-phone"></i>
        <div class="element-content">
          <span class="element-title">Mon numéro</span>
          <span class="element-value">
            {{ phoneNumber }}
          </span>
        </div>
      </div>

      <div class="element" @click="onEnter(wallpapers)">
        <i class="fa fa-picture-o"></i>
        <div class="element-content">
          <span class="element-title">Fond d'écran</span>
          <span class="element-value">
            {{ wallpaper.title }}
          </span>
        </div>
      </div>

      <div class="element" @click="onEnter(skins)">
        <i class="fa fa-mobile"></i>
        <div class="element-content">
          <span class="element-title">Coque</span>
          <span class="element-value">
            {{ skin.title }}
          </span>
        </div>
      </div>

      <div class="element" @click="onEnter(zoomFactors)">
        <i class="fa fa-search"></i>
        <div class="element-content">
          <span class="element-title">Zoom</span>
          <span class="element-value">
            {{ zoomFactor }}
          </span>
        </div>
      </div>

      <div class="element" style="color:#c0392b;" @click="onEnter(factoryReset)">
        <i class="fa fa-exclamation-triangle"></i>
        <div class="element-content">
          <span class="element-title">Formatter</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import List from './../List.vue'
  import Modal from '@/components/Modal/index.js'
  import { mapState } from 'vuex'
  import initialState from '../../store/initialState.js'

  import skinsConfig from './skins.json'
  import wallpapersConfig from './wallpapers.json'

  export default {
    components: { List },
    data () {
      return {
        wallpapers: {
          callback: 'changeWallpaper',
          values: wallpapersConfig
        },
        skins: {
          callback: 'changeSkin',
          values: skinsConfig
        },
        zoomFactors: {
          callback: 'setZoomFactor',
          values: [
            { title: '150%', value: '150%' },
            { title: '125%', value: '125%' },
            { title: '100%', value: '100%' },
            { title: '75%', value: '75%' }
          ]
        },
        factoryReset: {
          callback: 'resetPhone',
          values: [
            { title: 'TOUT SUPPRIMER', value: 'accept' },
            { title: 'Annuler', value: 'cancel' }
          ]
        }
      }
    },

    computed: {
      ...mapState(['phoneNumber', 'zoomFactor', 'wallpaper', 'skin'])
    },

    methods: {
      onEnter (elem) {
        if (elem.values !== undefined) {
          const choix = elem.values
          Modal.CreateModal({ choix }).then(response => {
            if (response.title === 'cancel') return
            this[elem.callback](elem, response)
          })
        }
      },

      changeWallpaper (param, data) {
        this.$store.commit('setWallpaper', data)
      },

      changeSkin (param, data) {
        this.$store.commit('setSkin', data)
      },

      setZoomFactor (param, data) {
        this.$store.commit('setZoomFactor', data.value)
      },

      resetPhone (param, data) {
        if (data.value === 'accept') {
          localStorage.clear()
          this.$store.replaceState(initialState())
        }
      },

      back () {
        this.$router.replace({ path: '/' })
      }
    }
  }
</script>

<style scoped>
  .screen{
    position: relative;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
  }
  .title{
    padding-left: 12px;
    height: 34px;
    line-height: 34px;
    font-weight: 700;
    color: white;
    background-color: #2c3e50;
  }

  .back-button {
    cursor: pointer;
  }

  .elements{
    height: calc(100% - 34px);
    overflow-y: auto;
  }
  .element{
    height: 40px;
    line-height: 40px;
    display: flex;
    align-items: center;
    position: relative;
  }
  .element .fa{
    color: #27ae60;
    margin-left: 6px;
    height: 32px;
    width: 32px;
    text-align: center;
    line-height: 32px;
  }
  .element-content{
    display: block;
    height: 40px;
    width: 100%;
    margin-left: 6px;
    display: flex;
    flex-flow: column;
    justify-content: center;
  }
  .element-title{
    display: block;
    margin-top: 4px;
    height: 22px;
    line-height: 22px;
    font-size: 0.8em;
  }
  .element-value{
    display: block;
    line-height: 8px;
    height: 8px;
    font-size: 0.6em;
    color: #808080;
  }
  .element:hover{
    background-color: #DDD;
  }
</style>
