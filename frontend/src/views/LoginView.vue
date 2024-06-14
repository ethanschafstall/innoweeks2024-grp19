<template>
  <div>
    <LoginFormVue @submit="login" />
  </div>
</template>

<script>
import axios from 'redaxios'
import LoginFormVue from '../components/LoginForm.vue'

export default {
  components: {
    LoginFormVue
  },
  methods: {
    async login() {
      {
        // Getting the username input value
        let username = 'testuser'

        // Getting the password input value
        let password = 'testuser'

        // Variable that contains the api call
        let APICall = 'https://feelings.blue.section-inf.ch/login'

        // POST with axios with the username and the password
        await axios
          .post(
            APICall,
            {
              username: username,
              password: password,
              platform: 'web'
            },
            {
              withCredentials: true
            }
          )
          .then((result) => {
            this.usernameError = ''
            this.passwordError = ''
            console.log(result)
          })
          .catch((error) => {
            if (error.status == 500) {
              this.errorMessage = error.data.message
            } else {
              this.errorMessage = 'The username or the password is incorrect'
            }
          })
      }
    }
  }
}
</script>

<style scoped></style>
