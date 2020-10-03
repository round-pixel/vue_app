<template lang="pug">
  v-app-bar(app)
    img(class="mr-3" :src="require('src/images/logo.png')" height="40")
    v-toolbar-title(class="font-weight-bold")
      slot(name='title')
    v-spacer
    v-toolbar-title {{ user.email }}
      v-btn(icon='' color='primary')
        v-icon(@click="sign_out") mdi-exit-to-app
</template>

<script>

  export default {
    data () {
      return {
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
            .catch(e => this.error = true)
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
