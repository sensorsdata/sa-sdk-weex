// Current running platform, could be "Android", "iOS" or "Web".
if (weex && weex.config.env.platform === 'Web') {
  const sa = require('sa-sdk-javascript');
  function callSdk(fn, args) {
    sa[fn] && sa[fn].apply(sa, args);
  }

  var isInit = false;
  var tmpServerUrl = {};
  // 注册到 Weex 扩展的对象
  var saWeexModule = {
    initSDK: function (para) {
      if (isInit) {
        sa.log('weex sdk is already init');
        return;
      }
      var config = sa._.extend({}, tmpServerUrl, para, para.web);
      tmpServerUrl = {};
      config.heatmap = config.heatmap || {
        clickmap: 'not_collect',
        scroll_notice_map: 'not_collect'
      };
      if (sa._.isBoolean(config.web_click)) {
        config.heatmap.clickmap = config.web_click ? 'default' : 'not_collect';
      }
      if (sa._.isBoolean(config.web_stay)) {
        config.heatmap.useCapture = true;
        config.heatmap.scroll_notice_map = config.web_stay ? 'default' : 'not_collect';
      }

      sa.init(config);

      sa._.isObject(config.super_properties) && sa.registerPage(config.super_properties);
      if (config.page_view === true) {
        sa.quick('autoTrack');
      }
      isInit = true;
    },
    setServerUrl: function (url) {
      if (sa.para) {
        sa.para.server_url = url;
      }
      else {
        tmpServerUrl.server_url = url;
      }
    },
    trackViewScreen: function (path, props) {
      sa.quick('autoTrackSinglePage', sa._.extend({ $path: path }, props, { $title: document.title }));
    },
    handlePageChanged: function (props) {
      sa.para && sa.para.page_view && sa.quick('autoTrackSinglePage', sa._.extend({}, props, { $title: document.title }));
    },
    registerApp: function (props) {
      sa.registerPage(props);
    },
    unRegister: function (propName) {
      sa._.isString(propName) && sa.clearPageRegister([propName]);
    },
    clearRegister: function () {
      sa.clearPageRegister(true);
    },
    incrementProfile: function (propName, value) {
      var p = {};
      p[propName] = value;
      sa.incrementProfile(p);
    },
    appendProfile: function (propName, value) {
      var p = {};
      p[propName] = value;
      sa.appendProfile(p);
    }
  };

  var funcsForWeexModule = ['login', 'logout', 'setProfile', 'setOnceProfile', 'unsetProfile', 'deleteProfile', 'track', 'bind', 'unbind', 'identify'];

  for (var i = 0; i < funcsForWeexModule.length; i++) {
    var fname = funcsForWeexModule[i];
    if (!saWeexModule[fname]) {
      saWeexModule[fname] = (function (fname) {
        return function () {
          callSdk(fname, arguments);
        };
      }(fname));
    }
  }

  // 将三端一致的实现注册到 Weex 扩展模块
  weex.registerModule('WeexSensorsDataAnalyticsModule', saWeexModule);
}