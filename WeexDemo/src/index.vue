<template>

    <div style="display: flex;flex-direction: row;flex-wrap: wrap;">
      <text @click="go_event" class="message">goEventTest</text>
      <text @click="go_widget" class="message">goWidgetTest</text>
      <router-view class="message" />
    </div>

</template>

<script>
var isBack = false;
export default {
  name: 'App',
  data() {
    return {
      logo: 'https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png',
      awidth: weex.config.env.deviceWidth,
      aheight: weex.config.env.deviceHeight,
    }
  }, methods: {
    go_event: function (e) {
      this.$router.push('/event');
    },
    go_widget: function (e) {
      this.$router.push('/widget');
    }
  },
}
</script>

<style scoped>
.fn-btn {
  background-color: darkcyan;
  color: white !important;
}

.fn-btn:hover {
  color: #41B883;
}

.btn-bg-green {
  background-color: cadetblue;
}

.pl-test {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
}

.wrapper {
  justify-content: center;
  align-items: center;
}

.greeting {
  text-align: center;
  margin-top: 70px;
  font-size: 50px;
  color: #41B883;
}

.message {
  margin: 10px 20px;
  font-size: 32px;
  color: #727272;
  border: 1px solid gray;
  padding: 10px 20px;
  border-radius: 10%;
  min-width: 200px;
}
</style>
