<template>
    <div class="max-w-md m-auto mt-8">
        <div class="border p-10 border-gray-300 shadow rounded">
            <h3 class="text-2xl text-gray-800 mb-8">Connexion</h3>
            <form @submit.prevent="signin">
                <div class="text-red" v-if="error">{{ error }}</div>
                <div class="mb-6">
                    <label for="phone_number" class="label">Numéro de téléphone</label>
                    <input type="text" v-model="phone_number" class="input" id="phone-number" placeholder="0760637308">
                </div>
                <div class="mb-6">
                    <label for="password" class="label">Mot de passe</label>
                    <input type="password" v-model="password" class="input" id="password">
                </div>
                <button type="submit" class="btn">Se connecter</button>
                <div class="my-4">
                    <router-link to="/signup" class="link-green">S'inscrire</router-link>
                </div>
            </form>
        </div>
    </div>
</template>
<script>
export default {
  name: 'Signin',
  data () {
    return {
      phone_number: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { phone_number: this.phone_number, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/conversations')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/conversations')
      }
    }
  }
}
</script>
