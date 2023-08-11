<template>
  <div class="wrapper">
    <text @click="clickfun" class="message">ChangeRouterView</text>
    <text @click="replace_two" class="message">replace_two</text>
    <text @click="push_two" class="message">push_two</text>
    <text @click="go_three" class="message">goThree</text>
    <text @click="go_back" class="message">back</text>
    <text @click="go_tab" class="message">goTab</text>
    <router-view  class="message"/>
  </div>
</template>

<script>
var isBack = false;
export default {
  name: 'App',
  data() {
    return {
      logo: 'https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png'
    }
  }, methods: {
    replace_two: function () {
      this.$router.replace('/two')
    },

    push_two: function () {
      this.$router.push('/two')
    },
    go_three: function () {
      this.$router.push({path:'/three',params:{hello:"WeexTitle"}})
    },
    go_back: function () {
      this.$router.back();
    },
    go_tab: function () {
      this.$router.replace('/tab');
    },
    clickfun: function () {
      if(!isBack){
        isBack = true;
        this.$router.push({path:'/one/mid/mytitle',params:{hello:"WeexTitle"}})
      }else{
        isBack =false;
        this.$router.push('/');
      }
      // this.$router.push('/one')
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
