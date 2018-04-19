<template>
  <div class="contact">
    <div class="title">{{ isEditing ? 'Edition' : 'Nouveau Contact' }}</div>
    <div class='content inputText'>
      <form @submit.prevent="isEditing ? editContact() : createContact()">
        <div class="group select">
          <input
          type="text"
          placeholder="Nouveau contact"
          autofocus
          v-model="contact.name"
          >
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Nom - Prenom</label>
        </div>

        <div class="group inputText">
          <input
            type="text"
            v-model="contact.phone_number"
          >
          <span class="highlight"></span>
          <span class="bar"></span>
          <label>Numéro</label>
        </div>

        <div class="group">
          <input
            type="submit"
            class="btn btn-green"
            value="Enregistrer"
          />
        </div>

        <div class="group">
          <input
            type="button"
            class="btn btn-orange"
            value="Annuler"
            @click="cancel"
          />
        </div>
        <div v-if="isEditing" class="group">
          <input
            type="button"
            class="btn btn-red"
            value="Supprimer"
            @click="deleteContact"
          />
        </div>
      </form>
    </div>
  </div>
</template>

<script>
  import Modal from '@/components/Modal/index.js'
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        contact: {
          name: '',
          phone_number: '',
          id: -1
        }
      }
    },
    methods: {
      createContact () {
        this.$http.post('http://gcphone/addContact', this.contact)
        // this.$store.commit('addContacts', { display: this.contact.display, phoneNumber: this.contact.number, id: Math.floor(Math.random() * 1000) })
        this.$router.go(-1)
      },

      editContact () {
        this.$http.post('http://gcphone/updateContact', this.contact)
        // this.$store.commit('addContacts', { display: this.contact.display, phoneNumber: this.contact.number })
        // request.updateContact(this.id, this.contact.display, this.contact.number)
        this.$router.go(-1)
      },

      cancel () {
        this.$router.go(-1)
      },

      deleteContact () {
        let choix = [{title: 'Supprimer', color: 'red'}, {title: 'Annuler'}]
        Modal.CreateModal({choix}).then(reponse => {
          if (reponse.title === 'Supprimer') {
            this.$http.post('http://gcphone/deleteContact', this.contact)
            this.$router.go(-1)
          }
        })
      }
    },
    computed: {
      ...mapGetters(['getContactById']),

      isEditing () {
        return typeof this.$route.params.id !== 'undefined'
      }
    },

    created () {
      if (typeof this.$route.params.id !== 'undefined') {
        const contact = this.getContactById(parseInt(this.$route.params.id, 10))
        if (!contact) {
          this.$router.replace({ path: '/' })
        }
        console.log(contact)
        this.contact = contact
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

  .title{
    padding-left: 16px;
    height: 34px;
    line-height: 34px;
    font-weight: 700;
    background-color: #5264AE;
    color: white;
  }

  .content{
    margin: 28px 10px 6px;
  }

  .group {
    position:relative;
    margin-top:16px;
  }

  .group.inputText {
    position:relative;
    margin-top:45px;
  }

  input {
    font-size:18px;
    display:block;
    width:100%;
    border:none;
    border-bottom:1px solid #757575;
  }

  input:focus {
    outline:none;
  }

  label {
    color:#999;
    font-size:18px;
    font-weight:normal;
    position:absolute;
    pointer-events:none;
    left:5px;
    top:10px;
    transition:0.2s ease all;
    -moz-transition:0.2s ease all;
    -webkit-transition:0.2s ease all;
  }

  input:focus ~ label, input:valid ~ label {
    top:-20px;
    font-size:14px;
    color:#5264AE;
  }

  .bar {
    position:relative; display:block; width:100%;
  }

  .bar:before, .bar:after 	{
    content:'';
    height:1px;
    width:0;
    bottom:1px;
    position:absolute;
    background:#5264AE;
    transition:0.2s ease all;
    -moz-transition:0.2s ease all;
    -webkit-transition:0.2s ease all;
  }

  .bar:before {
    left:50%;
  }

  .bar:after {
    right:50%;
  }

  input:focus ~ .bar:before, input:focus ~ .bar:after,
  .group.select input ~ .bar:before, .group.select input ~ .bar:after{
    width:50%;
  }

  .highlight {
    position:absolute;
    height:60%;
    width:100px;
    top:25%;
    left:0;
    pointer-events:none;
    opacity:0.5;
  }

  input:focus ~ .highlight {
    -webkit-animation:inputHighlighter 0.3s ease;
    -moz-animation:inputHighlighter 0.3s ease;
    animation:inputHighlighter 0.3s ease;
  }

  .group .btn {
    width: 100%;
    padding: 0px 0px;
    height: 34px;
    color: #fff;
    border: 0 none;
    font-size: 14px;
    font-weight: 500;
    line-height: 34px;
    color: #202129;
    background-color: #edeeee;
  }

  .group.select .btn {
    border: 3px solid #C0C0C0;
    line-height: 18px;
  }

  .group .btn.btn-green {
    background-color: #2ecc71;
    color: white;
  }

  .group.select .btn.btn-green {
    border-color:#27ae60;
  }

  .group .btn.btn-orange {
    background-color: #e67e22;
    color: white;
  }

  .group.select .btn.btn-orange{
    border-color: #d35400;
  }

  .group .btn.btn-red{
    background-color: #e74c3c;
    color: white;
  }

  .group.select .btn.btn-red{
    border-color: #c0392b;
  }

  @keyframes inputHighlighter {
    from { background:#5264AE; }
    to 	{ width:0; background:transparent; }
  }
</style>
