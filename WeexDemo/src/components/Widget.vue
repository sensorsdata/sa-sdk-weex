<template>
  <scroller class="scroller">
    <div>
      <a href="http://dotwe.org/raw/dist/a5e3760925ac3b9d68a3aa0cc0298857.bundle.wx">
        <text class="message">Jump</text>
      </a>
      <div @click='click' style="width: 600; height: 200; margin-left: 20; background-color:#F82e2f">
        <text>div 点击</text>
      </div>
      <text class="content message" @click='click'>TextClick</text>
      <image style="width:100px;height:100px; background-color:#a84e2f" class="message"
        src="https://vuejs.org/images/logo.png" @click="click"></image>
      <list class="message" @scroll="scroll" offset-accuracy=100 show-scrollbar=false>
        <cell @click="click" class="cell message" v-for="num in lists" :key="{ num }">
          <div class="panel">
            <text class="text">{{ num }}</text>
          </div>
        </cell>
      </list>
      <recycle-list class="list" for="(item, i) in longList" switch="type">
        <cell-slot case="static">
          <text @click="click">- {{item.type}} {{i}} -</text>
        </cell-slot>
      </recycle-list>

      <slider class="slider" interval="3000" auto-play="true" @click="click" @change="onchange">
        <div class="frame" v-for="img in imageList" :key="{ img }">
          <image style="width:100; height:100; background-color:#93252f" @click="click" resize="cover" :src="img.src">
          </image>
        </div>
      </slider>
      <textarea @click="click" class="message" @input="oninput" @change="onchange" @focus="onfocus" @blur="onblur"
        placeholder="textarea"></textarea>
      <div >
        <input @click="click"  class="message" type="text" placeholder="input placeholder"
          @input="eventInput" @change="onChange" @focus="onFocus" @blur="onBlur" @keyboard="onKeyBoard" />
      </div>
      <richtext @itemclick="click" @click="click" style="color:red;text-overflow:ellipsis">
        <span>link</span>
        <a pseudo-ref="21" @click="click" href="http://t.cn?_wx_tpl=http://g.tbcdn.cn/ali-wireless-h5/res/0.0.16/hello.js">
          <image style="width:150; height:150" src="https://img.alicdn.com/tps/i2/TB1hRb1IXXXXXX3XVXXXQaP.pXX-87-87.jpeg">
          </image>
          <span style="font-size:42;color:#FF5400;">TAOBAO</span>
        </a>
        <image style="width:300; height:300" src="http://www.fresher.ru/manager_content/images2/kadry-veka/big/2-1.jpg"
          pseudo-ref="23" @click="click"></image>
        <span
          @click="click">继承Transition继承Transition继承Transition继承Transition继承Transition继承Transition继承Transition继承Transition继承Transition</span>
      </richtext>
    </div>
  </scroller>
</template>

<script>

const modal = weex.requireModule('modal')
export default {
  name: 'App',
  data() {
    return {
      lists: ['A', 'B', 'C', 'D', 'E'],
      logo: 'https://gw.alicdn.com/tfs/TB1yopEdgoQMeJjy1XaXXcSsFXa-640-302.png',
      awidth: weex.config.env.deviceWidth,
      aheight: weex.config.env.deviceHeight,
      imageList: [
        { src: 'https://gd2.alicdn.com/bao/uploaded/i2/T14H1LFwBcXXXXXXXX_!!0-item_pic.jpg' },
        { src: 'https://gd1.alicdn.com/bao/uploaded/i1/TB1PXJCJFXXXXciXFXXXXXXXXXX_!!0-item_pic.jpg' },
        { src: 'https://gd3.alicdn.com/bao/uploaded/i3/TB1x6hYLXXXXXazXVXXXXXXXXXX_!!0-item_pic.jpg' }
      ],
      longList : [
  { type: 'A' },
  { type: 'B' },
  { type: 'B' },
  { type: 'A' },
  { type: 'B' }
]
    }
  }, methods: {
    click: function () {

    },
    onKeyBoard: function (e) {
      this.keyboard_state = '\n onkeyboard: ' + JSON.stringify(e)
    },
    oninput(event) {
      console.log('oninput:', event.value)
      modal.toast({
        message: `oninput: ${event.value}`,
        duration: 0.8
      })
    },
    onchange(event) {
      console.log('onchange:', event.value)
      modal.toast({
        message: `onchange: ${event.value}`,
        duration: 0.8
      })
    },
    onfocus(event) {
      console.log('onfocus:', event.value)
      modal.toast({
        message: `onfocus: ${event.value}`,
        duration: 0.8
      })
    },
    onblur(event) {
      console.log('onblur:', event.value)
      modal.toast({
        message: `input blur: ${event.value}`,
        duration: 0.8
      })
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

.content {
  margin: 20,
    padding：10
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
