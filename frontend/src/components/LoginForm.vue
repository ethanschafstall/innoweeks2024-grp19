<template>
  <div class="login-form">
    <form @submit.prevent="handleSubmit">
      <div class="form-group">
        <input
          type="text"
          id="username"
          v-model="username"
          @input="handleInput('username')"
          @blur="blurInput('username')"
          required
          autocomplete="off"
        />
        <label for="username" :class="{ transformed: usernameTyping || username }">Username</label>
      </div>
      <div class="form-group">
        <input
          type="password"
          id="password"
          v-model="password"
          @input="handleInput('password')"
          @blur="blurInput('password')"
          required
          autocomplete="off"
        />
        <label for="password" :class="{ transformed: passwordTyping || password }">Password</label>
      </div>
      <button type="submit" class="submit-btn">Login</button>
    </form>

    <transition name="fade">
      <div v-if="showError" class="error-box">
        <p>{{ errorMessage }}</p>
      </div>
    </transition>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  setup(props, { emit }) {
    const username = ref('')
    const password = ref('')
    const usernameTyping = ref(false)
    const passwordTyping = ref(false)
    const showError = ref(false)
    const errorMessage = ref('')

    const handleSubmit = () => {
      // Call parent method with form data
      emit('submit', {
        username: username.value,
        password: password.value
      })
    }

    const handleInput = (input) => {
      if (input === 'username') {
        usernameTyping.value = true
      } else if (input === 'password') {
        passwordTyping.value = true
      }
    }

    const blurInput = (input) => {
      if (input === 'username' && !username.value) {
        usernameTyping.value = false
      } else if (input === 'password' && !password.value) {
        passwordTyping.value = false
      }
    }

    return {
      username,
      password,
      usernameTyping,
      passwordTyping,
      showError,
      errorMessage,
      handleSubmit,
      handleInput,
      blurInput
    }
  }
}
</script>

<style scoped>
.login-form {
  max-width: 400px;
  margin: 0 auto;
}

.form-group {
  position: relative;
  margin-bottom: 20px;
}

input {
  margin: 3px;
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-sizing: border-box;
  outline: none;
}

label {
  color: grey;
  position: absolute;
  left: 15px;
  top: 10px;
  font-size: 14px;
  transition: all 0.3s;
}

.transformed {
  transform: translateY(-27px) scale(0.9) translateX(-10px);
  color: #777;
  transition-delay: 100ms;
}

button.submit-btn {
  display: block;
  width: 40%;
  padding: 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 10px;
}

button.submit-btn:hover {
  background-color: #0056b3;
}

.error-box {
  background-color: #ffcccc;
  padding: 15px;
  border: 1px solid #ff0000;
  border-radius: 5px;
  text-align: center;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
