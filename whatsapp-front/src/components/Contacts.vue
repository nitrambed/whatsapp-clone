<template>
    <div class="container m-auto mt-8">
        <div class="flex border p-10 border-gray-300 shadow rounded">
                <div class="w-1/3 bg-slate-100">
                     <ul class="list-reset mt-4">
                        <li class="py-4" v-for="contact in contacts" :key="contact.id" :contact="contact">
                        <p>{{ user_contact_firstname }} {{ user_contact_lastname }}</p>
                        </li>
                     </ul>
                </div>
                <div class="w-2/3"> Sélectionnez un contact pour démarrer une discussion </div>
        </div>
    </div>
</template>
<script>
export default {
  name: 'Contacts',
  data () {
    return {
      contacts: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/contacts')
        .then(response => { this.contacts = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>
