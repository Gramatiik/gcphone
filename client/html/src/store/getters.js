export default {
  getContactById: state => id => state.contacts.find(e => e.id === id),
  getMessageById: state => id => state.messages.find(e => e.id === id),
  getUnreadMessagesCount: state => state.messages.reduce((acc, msg) => msg.isRead ? acc + 1 : acc, 0),
  getMessagesThreads: state => {
    return state.messages.reduce((acc, message) => {
      (acc[message.from] = acc[message.from] || []).push(message)
      return acc
    }, {})
  }
}
