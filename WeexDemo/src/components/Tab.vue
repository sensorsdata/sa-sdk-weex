<template>
  <div >
    <text @click="go_tab1" class="message">GoTab1</text>
    <text @click="go_tab2" class="message">GoTab2</text>
    <text @click="go_back" class="message">GoBack</text>
    <router-view  class="message"/>
  </div>
</template>

<script>
export default {
name:'tab1',
  methods: {
    go_tab1: function () {
      this.$router.push('/tab1')
    },
    go_tab2: function () {
      this.$router.push('/tab2')
    },
    go_back: function () {
      this.$router.back();
    }
  },
  }
</script>
<style scoped>
.wrapper {
  justify-content: center;
  align-items: center;
}

.logo {
  width: 424px;
  height: 200px;
}

.greeting {
  text-align: center;
  margin-top: 70px;
  font-size: 50px;
  color: #41B883;
}

.message {
  margin: 30px;
  font-size: 32px;
  color: #727272;
}
</style>