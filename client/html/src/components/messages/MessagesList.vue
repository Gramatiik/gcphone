<template>
  <div class="screen">
    <list
      :list="messagesData"
      :backAction="back"
      title="Messages"
      @select="onSelect"
    ></list>
  </div>
</template>

<script>
import Modal from '@/components/Modal/index.js'
import List from '@/components/List'
import { mapState } from 'vuex'
export default {
  components: {
    List
  },
  data () {
    return {
      nouveauMessage: { backgroundColor: '#C0C0C0', display: 'Nouveau message', letter: '+', id: -1 }
    }
  },
  methods: {
    onSelect (data) {
      if (data.id === -1) {
        this.$router.push({ name: 'contacts.select' })
      } else {
        this.$router.push({ name: 'messages.view', params: { id: data.number, display: data.display } })
      }
    },
    onOption (data) {
      Modal.CreateModal({
        choix: [
          {id: 1, title: 'Effacer la conversation', icons: 'fa-circle-o'},
          {id: 2, title: 'Effacer toutes conv.', icons: 'fa-circle-o'},
          {id: 3, title: 'Annuler', icons: 'fa-undo'}
        ]
      }).then(rep => {
        if (rep.id === 1) {
          // request.deleteMessageNumber(data.number)
        } else if (rep.id === 2) {
          // request.deleteAllMessage()
        }
        this.disableList = false
      })
    },

    back () {
      this.$router.replace({path: '/'})
    }
  },
  computed: {
    ...mapState(['messages', 'contacts']),
    messagesData () {
      let messGroup = this.messages.reduce((rv, x) => {
        if (rv[x['transmitter']] === undefined) {
          let contact = this.contacts.find(e => e.number === x.transmitter)
          let display = contact !== undefined ? contact.display : x.transmitter
          rv[x['transmitter']] = {noRead: 0, display}
        }
        if (x.isRead === 0) {
          rv[x['transmitter']].noRead += 1
        }
        rv[x['transmitter']].lastMessage = Math.max(x.time, rv[x['transmitter']].lastMessage || 0)
        return rv
      }, {})
      let mess = []
      Object.keys(messGroup).forEach(key => {
        mess.push({
          display: messGroup[key].display,
          puce: messGroup[key].noRead,
          number: key,
          lastMessage: messGroup[key].lastMessage
        })
      })
      mess.sort((a, b) => b.lastMessage - a.lastMessage)
      return [this.nouveauMessage, ...mess]
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
</style>
