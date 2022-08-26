<template>
    <div class="container m-auto mt-8">
        <div class="flex border p-10 border-gray-300 shadow rounded">
                <div class="w-1/3 bg-slate-100">
                     <ul class="list-reset mt-4">
                        <li class="py-4" v-for="conversation in conversations" :key="conversation.id" :conversation="conversation">
                        <p>{{ user_contact_firstname }} {{ user_contact_lastname }}</p>
                        </li>
                     </ul>
                </div>
                <div class="w-2/3"> Sélectionnez une conversation </div>
        </div>
    </div>
</template>

<script>
export default {
  name: 'Conversations',
  data () {
    return {
      messages: [],
      conversations: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/conversations')
        .then(response => { this.conversations = response.data })
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
