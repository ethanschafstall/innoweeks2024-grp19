<template>
  <div>
    <RegisterFormVue @submit="register" />
  </div>
</template>

<script>
import axios from 'redaxios';
import RegisterFormVue from '../components/RegisterForm.vue';

export default {
  components:{
    RegisterFormVue
  },
  data() {
    return {
      username: '',
      password: '',
      confirmPassword: '',
      errorMessage: ''
    };
  },
  methods: {
    async register() {
      if (this.password !== this.confirmPassword) {
        this.errorMessage = 'Passwords do not match!';
        return;
      }

      try {
        const response = await axios.post('https://feelings.blue.section-inf.ch/register', {
          username: this.username,
          password: this.password
        });
        // console.log(response);
        // handle successful registration
        this.errorMessage = ''; // Clear error message on success
      } catch (error) {
        console.log(error)
        this.errorMessage = error.data.error;
      }
    }
  }
};
</script>

<style scoped>
.error {
  color: red;
  margin-top: 10px;
}
</style>
