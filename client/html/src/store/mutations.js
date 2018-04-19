export default {
  setMyPhoneNumber (state, value) {
    state.phoneNumber = value
  },

  setZoomFactor (state, value) {
    localStorage.setItem('gcphone:zoomFactor', value)
    state.zoomFactor = value
  },

  setSkin (state, value) {
    localStorage.setItem('gcphone:skin', JSON.stringify(value))
    state.skin = value
  },

  setWallpaper (state, value) {
    localStorage.setItem('gcphone:wallpaper', JSON.stringify(value))
    state.wallpaper = value
  },

  setMessages (state, messages) {
    state.messages = messages
  },

  addMessages (state, ...messages) {
    state.messages = [...state.messages, ...messages]
  },

  removeMessages (state, ...messages) {
    state.messages = state.messages.filter(e => messages.indexOf(e) === -1)
  },

  setContacts (state, contacts) {
    state.contacts = contacts
  },

  addContacts (state, ...contacts) {
    state.contacts = [...state.contacts, ...contacts]
  },

  removeContacts (state, ...contacts) {
    state.contacts = state.contacts.filter(e => contacts.indexOf(e) === -1)
  },

  setShow (state, status) {
    state.show = status
  }
}
