<template>
  <div class="contact">
    <list :list='lcontacts' title="Contacts" v-on:select="onSelect"></list>
  </div>
</template>

<script>
  import List from './../List.vue'
  export default {
    components: {
      List
    },
    data () {
      return {
        contacts: []
      }
    },
    computed: {
      lcontacts () {
        return [
          ...this.$store.state.contacts.slice().sort((a, b) => a.display.localeCompare(b.display)),
          { display: 'Entrez un numéro', letter: '+', backgroundColor: 'orange', num: -1 }
        ]
      }
    },
    methods: {
      onSelect (contact) {
        if (contact.num === -1) {
          /* request.getReponseText({
            limit: 10
          }).then(data => {
            let message = data.text.trim()
            if (message !== '') {
              this.$router.push({ name: 'messages.view', params: { id: message, display: message } })
            }
          }) */
        } else {
          this.$router.push({ name: 'messages.view', params: { id: contact.id, display: contact.display } })
        }
      },
      back () {
        this.$router.go(-1)
      }
    }
  }
</script>

<style scoped>
  .contact{
    position: relative;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
  }
</style>
