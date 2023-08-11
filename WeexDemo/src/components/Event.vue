<template>
  <scroller class="scroller" >

    <div >

      <text @touchstart="md" @touchend="mu" @click="init" class="message fn-btn"
        style="background-color: brown;">先init</text>
      <text @touchstart="md" @touchend="mu" @click="track" class="message fn-btn">track</text>
      <text @touchstart="md" @touchend="mu" @click="login" class="message fn-btn">login</text>
      <text @touchstart="md" @touchend="mu" @click="logout" class="message fn-btn">logout</text>
      <text @touchstart="md" @touchend="mu" @click="bind" class="message fn-btn">bind</text>
      <text @touchstart="md" @touchend="mu" @click="unbind" class="message fn-btn">unbind</text>

      <text @touchstart="md" @touchend="mu" @click="setProfile" class="message fn-btn">setProfile</text>
      <text @touchstart="md" @touchend="mu" @click="setOnceProfile" class="message fn-btn">setOnceProfile</text>
      <text @touchstart="md" @touchend="mu" @click="incrementProfile" class="message fn-btn">incrementProfile</text>
      <text @touchstart="md" @touchend="mu" @click="appendProfile" class="message fn-btn">appendProfile</text>
      <text @touchstart="md" @touchend="mu" @click="unsetProfile" class="message fn-btn">unsetProfile</text>
      <text @touchstart="md" @touchend="mu" @click="deleteProfile" class="message fn-btn">deleteProfile</text>

      <text @touchstart="md" @touchend="mu" @click="trackViewScreen" class="message fn-btn">trackViewScreen</text>
      <text @touchstart="md" @touchend="mu" @click="register" class="message fn-btn">register</text>
      <text @touchstart="md" @touchend="mu" @click="unRegister" class="message fn-btn">unRegister</text>
      <text @touchstart="md" @touchend="mu" @click="clearRegister" class="message fn-btn">clearRegister</text>
      <text @touchstart="md" @touchend="mu" @click="identify" class="message fn-btn">identify</text>
      <text @touchstart="md" @touchend="mu" @click="setServerUrl" class="message fn-btn">setServerUrl</text>
      <text @touchstart="md" @touchend="mu" @click="testWrongArg" class="message fn-btn">错误传参调用</text>

      app 特有：
      <text @touchstart="md" @touchend="mu" @click="trackTimerStart"
        class="message fn-btn btn-bg-green">trackTimerStart</text>
      <text @touchstart="md" @touchend="mu" @click="trackTimerEnd"
        class="message fn-btn btn-bg-green">trackTimerEnd</text>
      <text @touchstart="md" @touchend="mu" @click="trackTimerPause"
        class="message fn-btn btn-bg-green">trackTimerPause</text>
      <text @touchstart="md" @touchend="mu" @click="trackTimerResume"
        class="message fn-btn btn-bg-green">trackTimerResume</text>
      <text @touchstart="md" @touchend="mu" @click="clearTrackTimer"
        class="message fn-btn btn-bg-green">clearTrackTimer</text>
      <text @touchstart="md" @touchend="mu" @click="flush" class="message fn-btn btn-bg-green">flush</text>
      <text @touchstart="md" @touchend="mu" @click="deleteAll" class="message fn-btn btn-bg-green">deleteAll</text>
      <text @touchstart="md" @touchend="mu" @click="resetAnonymousId"
        class="message fn-btn btn-bg-green">resetAnonymousId</text>
      <text @touchstart="md" @touchend="mu" @click="trackAppInstall"
        class="message fn-btn btn-bg-green">trackAppInstall</text>

      web 全埋点元素：
      <a style="color:blue;" href='#'>链接</a>
      <button class="message">按钮</button>
      <input class="message" value='输入框' />
      <textarea class="message" value="富文本框"></textarea>

      <text @click="go_home" class="message">goHome</text>
      <text @click="go_tab" class="message">goTab</text>
      <router-view class="message" />

    </div>
  </scroller>
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
    init: function () {
      if (weex.config.env.platform !== 'Web') {
        this.$sensors.init({
          server_url: 'http://10.129.20.62:8106/sa?project=lixiaodong',
          show_log: true,//是否开启日志
          super_properties: { // 配置全局属性，所有上报事件属性中均会携带， web 通过 registerPage 实现
            register_from_super_properties: 'this is a super property'
          },
          web: {//web 初始化配置
            send_type: 'image',
            page_view: true,
            web_click: true,
            web_stay: true

          },
          app: {// Android & iOS 初始化配置
            // app weex 扩展翻译为 app sdk 枚举
            app_start: true,
            app_end: true,
            view_screen: true,
            view_click: true

            // 全埋点开关，默认不开启
          }
        })
      } else {
        this.$sensors.init({
          server_url: 'http://10.129.20.62:8106/sa?project=lixiaodong',
          show_log: true,//是否开启日志
          super_properties: { // 配置全局属性，所有上报事件属性中均会携带， web 通过 registerPage 实现
            register_from_super_properties: 'this is a super property'
          },
          web: {//web 初始化配置
            send_type: 'image',
            page_view: true,
            web_click: true,
            web_stay: true

          },
          app: {// Android & iOS 初始化配置
            // app weex 扩展翻译为 app sdk 枚举
            app_start: true,
            app_end: true,
            view_screen: true,
            view_click: true

            // 全埋点开关，默认不开启
          }
        });
      }
    },
    md: function (e) {
      if (e.target.tagName === 'P') {
        e.target.style.scale = '0.9'
      }
    },
    mu: function (e) {
      if (e.target.tagName === 'P') {
        e.target.style.scale = '1'
      }
    },
    track: function () {
      this.$sensors.track("hello", { hello_props: 'hello world', buy_time: new Date })
    },
    login: function () {
      this.$sensors.login('ID22345678')
    },
    logout: function () {
      this.$sensors.logout();
    },
    bind: function () {
      this.$sensors.bind('wexin', 'wx1234567')
    },
    unbind: function () {
      this.$sensors.unbind('wexin', 'wx1234567')
    },
    setProfile: function () {
      this.$sensors.setProfile({
        name: 'Alex Le',
        age: '18'
      });
    },
    setOnceProfile: function () {
      this.$sensors.setOnceProfile({
        address: '21 street'
      })
    },
    incrementProfile: function () {
      this.$sensors.incrementProfile('level', 10)
    },
    appendProfile: function () {
      this.$sensors.appendProfile('favorite', ['apple', 'orange'])
    },
    unsetProfile: function () {
      this.$sensors.unsetProfile('level');
    },
    deleteProfile: function () {
      this.$sensors.deleteProfile();
    },
    trackViewScreen: function () {
      this.$sensors.trackViewScreen('/abc_manual_track', { track_pv: 'manual track' })
    },
    register: function () {
      this.$sensors.register({
        reg_prop1: 'value1',
        reg_prop2: 'value2'
      })
    },
    unRegister: function (propName) {
      this.$sensors.unRegister('reg_prop1');
    },
    clearRegister: function () {
      this.$sensors.clearRegister();
    },
    identify: function () {
      this.$sensors.identify('my_self_def_id1234567');
    },
    setServerUrl: function () {
      this.$sensors.setServerUrl('https://www.baidu.com');
    },

    trackTimerStart: function () {
      this.$sensors.trackTimerStart('trackTimer');
    },
    trackTimerEnd: function () {
      this.$sensors.trackTimerEnd('trackTimer');
    },
    trackTimerPause: function () {
      this.$sensors.trackTimerPause('trackTimer')
    },
    trackTimerResume: function () {
      this.$sensors.trackTimerResume('trackTimer');
    },
    clearTrackTimer: function () {
      this.$sensors.clearTrackTimer();
    },
    trackAppInstall: function () {
      this.$sensors.trackAppInstall({
        prop_app_install: 'app installed'
      });
    },
    flush: function () {
      this.$sensors.flush();
    },
    deleteAll: function () {
      this.$sensors.deleteAll();
    },
    resetAnonymousId: function () {
      this.$sensors.resetAnonymousId();
    },

    go_tab: function () {
      this.$router.push('/tab');
    },
    go_home: function () {
      this.$router.push('/home');
    },
    testWrongArg: function () {
      this.$sensors.track(1);
      this.$sensors.track('a', 2);
      this.$sensors.track(/21/, 2);
      this.$sensors.setProfile({ p4: /123/ });
      this.$sensors.setOnceProfile({ p4: /123/ });
      this.$sensors.setOnceProfile({ p4: function () { } });
      this.$sensors.incrementProfile('abc', 'efg');
      this.$sensors.incrementProfile(123, 'efg');
      this.$sensors.appendProfile('e123', 'efg');
      this.$sensors.appendProfile(3454, 'efg');
      this.$sensors.unsetProfile(3454, 'efg');
      this.$sensors.login(3454, 'efg');
      this.$sensors.bind(3454, 'efg');
      this.$sensors.bind('3454', 456);
      this.$sensors.unbind('3454', 456);
      this.$sensors.unbind(3454, 456);
      this.$sensors.setServerUrl(3454, 456);
      this.$sensors.identify(3454, 456);
      this.$sensors.unRegister(3454, 456);
      this.$sensors.trackViewScreen(3454, 456);
      this.$sensors.trackTimerStart(3454, 456);
      this.$sensors.trackTimerEnd(3454, 456);
      this.$sensors.trackTimerPause(3454, 456);
      this.$sensors.trackTimerResume(3454, 456);
      this.$sensors.trackAppInstall(3454, 456);
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
