<template>
  <div class="contact">
    <list
      title="Contacts"
      keyDisplay="name"
      :list="lcontacts"
      :backAction="back"
      @select="selectContact"
    ></list>
  </div>
</template>

<script>
import List from '../List.vue'

export default {
  components: { List },
  computed: {
    lcontacts () {
      return [
        ...this.$store.state.contacts.slice().sort((a, b) => a.name.localeCompare(b.name)),
        { name: 'Ajouter un contact', letter: '+', num: '', id: 'new' } // new contact item
      ]
    }
  },
  methods: {
    selectContact (contact) {
      this.$router.push(
        contact.id === 'new'
        ? { name: 'contacts.new' }
        : { name: 'contacts.view', params: { id: contact.id } }
      )
    },

    back () {
      this.$router.replace({path: '/'})
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
