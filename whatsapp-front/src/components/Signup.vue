<template>
    <div class="max-w-md m-auto mt-8">
        <div class="border p-10 border-gray-300 shadow rounded">
            <h3 class="text-2xl text-gray-800 mb-8">Connexion</h3>
            <form @submit.prevent="signup">
                <div class="text-red" v-if="error">{{ error }}</div>
                <div class="mb-6">
                    <label for="phone_number" class="label">Numéro de téléphone</label>
                    <input type="text" v-model="phone_number" class="input" id="phone-number" placeholder="0760637308">
                </div>
                <div class="mb-6">
                    <label for="password" class="label">Mot de passe</label>
                    <input type="password" v-model="password" class="input" id="password">
                </div>
                <div class="mb-6">
                    <label for="password_confirmation" class="label">Confirmation Mot de passe</label>
                    <input type="password" v-model="password_confirmation" class="input" id="password_confirmation">
                </div>
                <button type="submit" class="btn">S'inscrire'</button>
                <div class="my-4">
                    <router-link to="/signin" class="link-green">Se connecter</router-link>
                </div>
            </form>
        </div>
    </div>
</template>
<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { phone_number: this.phone_number, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/contacts')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/contacts')
      }
    }
  }
}
</script>
