<template lang="pug">
  div
    template(v-if="loading")
      p Loading...
    template(v-else-if="error")
      p Error :(
    template(v-else)
      v-app-bar(app='' color='light-blue accent-1')
        img(class="mr-3" :src="require('staff/src/images/logo.png')" height="40")
        v-toolbar-title(class="font-weight-bold") Staff Dashboard
        v-spacer
        v-toolbar-title {{ user.email }}
          v-btn(icon='' color="orange darken-2")
            v-icon(@click="sign_out") mdi-exit-to-app
</template>

<script>

  export default {
    data () {
      return {
        loading: true,
        error: false,
        user: {}
      }
    },
    created() {
      this.fetchUser()
    },
    methods: {
      fetchUser () {
        this.loading = true
        setTimeout(()=> {
          this.$api.current()
            .then(response => this.user = response.data)
            .catch((e) => this.error = true)
            .finally(() => this.loading = false)
        }, 100)
      },

      sign_out() {
        this.$api.sign_out()
          .then(() => location.reload())

      }
    }
  }
</script>

<style lang="sass" scoped>
  p
    font-size: 2em
    text-align: center
    margin-top: 5em
</style>
