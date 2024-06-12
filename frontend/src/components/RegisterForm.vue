<template>
    <div class="login-form">
      <form @submit.prevent="handleSubmit">
        <div class="form-group">
          <input type="text" id="username" v-model="username" @input="handleInput('username')" @blur="blurInput('username')" required autocomplete="off">
          <label for="username" :class="{ 'transformed': usernameTyping || username }">Username</label>
        </div>
        <div class="form-group">
          <input type="password" id="password" v-model="password" @input="handleInput('password')" @blur="blurInput('password')" required autocomplete="off">
          <label for="password" :class="{ 'transformed': passwordTyping || password }">Password</label>
        </div>
        <div class="form-group">
          <input type="password" id="confirmPassword" v-model="confirmPassword" @input="handleInput('confirmPassword')" @blur="blurInput('confirmPassword')" required autocomplete="off">
          <label for="confirmPassword" :class="{ 'transformed': confirmPasswordTyping || confirmPassword }">Confirm Password</label>
        </div>
        <button type="submit" class="submit-btn">Register</button>
      </form>
    
      <transition name="fade">
        <div v-if="showError" class="error-box">
          <p>{{ errorMessage }}</p>
        </div>
      </transition>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        username: '',
        password: '',
        confirmPassword: '',
        usernameTyping: false,
        passwordTyping: false,
        confirmPasswordTyping: false,
        showError: false,
        errorMessage: ''
      };
    },
    methods: {
      handleSubmit() {
        // Check if passwords match
        if (this.password !== this.confirmPassword) {
          this.showError = true;
          this.errorMessage = 'Passwords do not match';
          setTimeout(() => {
            this.showError = false;
            this.errorMessage = '';
          }, 4000);
          return;
        }
    
        // Password length validation
        if (this.password.length < 8 || this.password.length > 100) {
          this.showError = true;
          this.errorMessage = 'Password must be between 8 and 100 characters';
          setTimeout(() => {
            this.showError = false;
            this.errorMessage = '';
          }, 4000);
          return;
        }
    
        // Call parent method with form data
        this.$emit('submit', {
          username: this.username,
          password: this.password
        });
      },
      handleInput(input) {
        this[`${input}Typing`] = true;
      },
      blurInput(input) {
        if (!this[input]) {
          this[`${input}Typing`] = false;
        }
      }
    }
  };
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
  
  .fade-enter-active, .fade-leave-active {
    transition: opacity 0.5s;
  }
  
  .fade-enter, .fade-leave-to {
    opacity: 0;
  }
  </style>
  