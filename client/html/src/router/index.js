import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Contacts from '@/components/contacts/Contacts'
import ContactsSelect from '@/components/contacts/ContactsSelect'
import Contact from '@/components/contacts/Contact'
import MessagesList from '@/components/messages/MessagesList'
import Messages from '@/components/messages/Messages'
import Call from '@/components/call/Call'
import Settings from '@/components/settings/Settings'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/contacts',
      name: 'contacts',
      component: Contacts
    },
    {
      path: '/contacts/select',
      name: 'contacts.select',
      component: ContactsSelect
    },
    {
      path: '/contacts/new',
      name: 'contacts.new',
      component: Contact
    },
    {
      path: '/contacts/:id',
      name: 'contacts.view',
      component: Contact
    },
    {
      path: '/messages',
      name: 'messages',
      component: MessagesList
    },
    {
      path: '/messages/:id/:display',
      name: 'messages.view',
      component: Messages
    },
    {
      path: '/phone',
      name: 'phone',
      component: Call
    }, {
      path: '/settings',
      name: 'settings',
      component: Settings
    }, {
      path: '*',
      redirect: '/'
    }
  ]
})
