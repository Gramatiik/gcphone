<template>
  <div class="messages">
    <div class='sms_contact'>
      <i
        class="back-button fa fa-long-arrow-left"
        @click="$router.push({ name: 'messages' })"
      ></i>
      {{display}}
    </div>

    <div class="sms_list">
        <div
          v-for="(msg, key) in messages"
          :key="msg.id"
          class="sms"
        >
            <span class='sms_message sms_me'
              v-bind:class="{ sms_other: msg.owner === 0}">
                {{ msg.message }}
                <span class="sms_time"><timeago :since='msg.time * 1000' :auto-update="20"></timeago></span>
            </span>
        </div>
    </div>

    <form class="sms__write" @submit.prevent="sendMessage">
        <input
          type="text"
          class="sms__write__input"
          placeholder="Message"
          v-model="newMessage"
        >
        <button class="sms__write__send">
          <i class="fa fa-arrow-up"></i>
        </button>
    </form>
  </div>
</template>

<script>
  import Modal from '@/components/Modal/index.js'
  import { mapState } from 'vuex'
  export default {
    data () {
      return {
        newMessage: '',
        display: '',
        phoneNumber: ''
      }
    },

    methods: {
      sendMessage () {
        if (this.newMessage.lenght !== 0) {
          this.$store.commit('addMessages', {
            id: Math.round(Math.random() * 1000),
            time: new Date(),
            message: this.newMessage,
            owner: Math.round(Math.random())
          })
          this.newMessage = ''
        }
        /* if (this.selectMessage !== -1) {
          this.onActionMessage()
        } else {
          request.getReponseText().then(data => {
            let message = data.text.trim()
            if (message !== '') {
              request.sendMessage(this.phoneNumber, message)
            }
          })
        } */
      },

      onActionMessage () {
        /* let message = this.messages[this.selectMessage]
        let isGPS = /^GPS: -?\d*(\.\d+), -?\d*(\.\d+)/.test(message.message)
        let choix = [{
          title: 'Effacer',
          icons: 'fa-circle-o'
        }, {
          title: 'Annuler',
          icons: 'fa-undo'
        }]
        if (isGPS === true) {
          choix = [{
            title: 'Position GPS',
            icons: 'fa-location-arrow'
          }, ...choix]
        }
        Modal.CreateModal({choix}).then(data => {
          if (data.title === 'Effacer') {
            // request.deleteMessage(message.id)
            this.messages.splice(this.selectMessage, 1)
          } else if (data.title === 'Position GPS') {
            let val = message.message.match(/((-?)\d+(\.\d+))/g)
            // request.setGPS(val[0], val[1])
          }
        }) */
      },

      onRight () {
        if (this.selectMessage === -1) {
          Modal.CreateModal({choix: [
            {title: 'Envoyer Coord GPS', icons: 'fa-location-arrow'},
            {title: 'Annuler', icons: 'fa-undo'}
          ]}).then(data => {
            if (data.title === 'Envoyer Coord GPS') {
              // request.sendMessage(this.phoneNumber, '%pos%')
            }
          })
        }
      }
    },

    computed: {
      ...mapState(['messages'])
    },

    created () {
      this.display = this.$route.params.display
      this.phoneNumber = this.$route.params.id
      // this.$http.post('http://gcphone/setReadMessageNumber', { number: this.phoneNumber })
    }
  }
</script>

<style lang="scss" scoped>
  .messages{
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: calc(100% - 20px);
      background-color: #DDD;
  }

  .sms_contact {
      background-color: #4CAF50;
      color: white;
      height: 34px;
      line-height: 34px;
      padding-left: 5px;
  }

  .sms_list {
      height: calc(100% - 34px - 26px);
      overflow-y: auto;
      padding-bottom: 8px;
  }

  .sms_send {

  }

  .sms {
    overflow: auto;
    zoom: 1;
  }

  .sms_me {
    float: right;
    background-color: white;
    padding: 5px 10px;
    max-width: 90%;
    margin-right: 5%;
    margin-top: 10px;
  }

  .sms_other {
    background-color: #4CAF50;
    color:white;
    float: left;
    padding: 5px 10px;
    max-width: 90%;
    margin-left: 5%;
    margin-top: 10px;
  }

  .sms_time {
    display: block;
    font-size: 0.5em;
  }

  .sms_me .sms_time{
    color: #AAA;
  }

  .sms_other .sms_time{
    color: #555;
  }

  .messages {
    position: relative;
    width: 100%;
    height: 100%;
  }

  .sms .sms_message {
    background-color: lightskyblue;
  }

  .sms_message {
    word-wrap: break-word;
    max-width: 80%;
  }

  .sms__write {
    height: 26px;

    &__input {
      width: 78%;
      margin-left: 6%;
      border: none;
      outline: none;
      font-size: 0.6em;
      padding: 3px 5px;
      float: left;
    }

    &__send {
      border: none;
      width: 20px;
      height: 20px;
      float: right;
      border-radius: 50%;
      background-color: orange;
      margin-right: 6px;
      padding: 0;
      text-align: center;
      color: white;
      line-height: 20px;
      font-size: 14px;
      cursor: pointer;
    }
  }
</style>
