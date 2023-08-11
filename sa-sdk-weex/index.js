import { isArray, isNumber, isString, isObject, searchObjDate, each, isBoolean } from 'wrenchjs';
import './weex-module-web.js';
import weexSDKVesion from './lib-plugin-version.js';

const saWeexModule = weex.requireModule('WeexSensorsDataAnalyticsModule');

function logTypeError(fname, argPosition, type) {
  console.error('function [' + fname + '] ' + 'No.' + argPosition + ' argument must be ' + type);
}

const SAPropsRules = {
  StringArray: {
    check: function (val, fname, argPosition) {
      var isPass = false;
      if (isArray(val)) {
        for (var i = 0; i < val.length; i++) {
          if (!isString(val[i])) {
            break;
          }
        }
        isPass = true;
      }
      !isPass && logTypeError(fname, argPosition, 'Array<String>');
      return isPass;
    }
  },
  StringRaw: {
    check: function (val, fname, argPosition) {
      if (isString(val)) {
        return true;
      }
      logTypeError(fname, argPosition, 'String');
      return false;
    }
  },
  NumberRaw: {
    check: function (val, fname, argPosition) {
      if (isNumber(val)) {
        return true;
      }
      logTypeError(fname, argPosition, 'String');
      return false;
    }
  },
  SAPropertyObject: {
    check: function (val, fname, argPosition) {
      searchObjDate(val);

      if (val && !isObject(val)) {
        logTypeError(fname, argPosition, 'Object');
        return false;
      }

      var isPass = true;
      each(val, function (value, key) {
        if (!isString(key)) {
          isPass = false;
          return;
        }
        if (!isString(value) && !isNumber(value) && !isBoolean(value) && !isArray(value)) {
          isPass = false;
          return;
        }
      });

      !isPass && logTypeError(fname, argPosition, 'Object, and its key must be string and value type limits [String、Number、Boolean、Array]');
      return isPass;
    }
  }
};

const apisToExport = [
  ['login', ['StringRaw']],
  ['logout', []],
  ['bind', ['StringRaw', 'StringRaw']],
  ['unbind', ['StringRaw', 'StringRaw']],
  ['setProfile', ['SAPropertyObject']],
  ['setOnceProfile', ['SAPropertyObject']],
  ['incrementProfile', ['StringRaw', 'NumberRaw']],
  ['appendProfile', ['StringRaw', 'StringArray']],
  ['unsetProfile', ['StringRaw']],
  ['deleteProfile', []],
  ['track', ['StringRaw', 'SAPropertyObject']],
  ['setServerUrl', ['StringRaw']],
  ['identify', ['StringRaw']],
  ['unRegister', ['StringRaw']],
  ['clearRegister', []],
  ['trackViewScreen', ['StringRaw', 'SAPropertyObject']],
  ['trackTimerStart', ['StringRaw']],
  ['trackTimerEnd', ['StringRaw', 'SAPropertyObject']],
  ['clearTrackTimer', []],
  ['flush', []],
  ['deleteAll', []],
  ['trackTimerPause', ['StringRaw']],
  ['trackTimerResume', ['StringRaw']],
  ['resetAnonymousId', ['']],
  ['trackAppInstall', ['SAPropertyObject']]
];

var sensors = {
  init: function () {
    callWeexModule('initSDK', arguments);
  },
  register: function () {
    if (SAPropsRules.SAPropertyObject.check(arguments[0])) {
      callWeexModule('registerApp', arguments);
    }
  },
  useRouter: useRouter,
  track: (function () {
    var isFirstTrack = true;
    return function (event, props) {
      if (SAPropsRules.StringRaw.check(event, 'track', 1) && SAPropsRules.SAPropertyObject.check(props, 'track', 2)) {
        if (isFirstTrack) {
          props = props || {};
          props['$lib_plugin_version'] = ['weex:' + weexSDKVesion];
        }
        callWeexModule('track', [event, props]);
        isFirstTrack = false;
      }
    };
  }())
};

for (var i = 0; i < apisToExport.length; i++) {
  var fnDef = apisToExport[i];
  var fn = fnDef[0];
  var fnArgRules = fnDef[1];

  if (!sensors[fn]) {
    sensors[fn] = (function (name, argRules) {
      return function () {
        // verify argument type
        for (var k = 0; k < argRules.length; k++) {
          if (SAPropsRules[argRules[k]]) {
            var pass = SAPropsRules[argRules[k]].check(arguments[k], name, k + 1);
            if (!pass) {
              return;
            }
          }
        }
        callWeexModule(name, arguments);
      };
    }(fn, fnArgRules));
  }
}

function useRouter(router) {
  if (router && typeof router === 'object') {
    try {
      Object.prototype.toString.call(router.afterEach) === '[object Function]' && router.afterEach((to, from, failure) => {
        if (!failure) {
          if (to.matched.length > 0) {
            var index = to.matched.length - 1;
            var props = to.matched[index].props;
            var title = props.title ? props.title : props.default && props.default.title ? props.default.title : to.name;
            var path = props.path ? props.path : props.default && props.default.path ? props.default.path : to.path;
            props = props.sa_props ? props.sa_props : props.default && props.default.sa_props ? props.default.sa_props : {};
            saWeexModule.handlePageChanged(Object.assign({ $title: title, $screen_name: path }, props));
          }
        }
        else {
          console.log('vue router error:', failure);
        }
      });
    } catch (error) {
      console.error('outer.afterEach callback error', error);
    }
  } else {
    console.error('router obj is invalid');
  }
}

function callWeexModule(fn, args) {
  if (!saWeexModule) {
    console.error('Sensors Weex Module is not registered');
    return;
  }
  if (!saWeexModule[fn]) {
    console.warn(fn + ' function is not found.');
    return;
  }

  saWeexModule[fn] && saWeexModule[fn].apply(saWeexModule, args);
}

export default sensors;