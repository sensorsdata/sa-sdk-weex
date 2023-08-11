package com.weex.app;

import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSONArray;
import com.sensorsdata.analytics.android.sdk.SensorsAnalyticsAutoTrackEventType;
import com.sensorsdata.analytics.android.sdk.SensorsDataAPI;
import com.sensorsdata.analytics.android.sdk.SAConfigOptions;
import com.sensorsdata.analytics.android.sdk.SALog;
import com.sensorsdata.analytics.android.sdk.SensorsDataAPIEmptyImplementation;
import com.sensorsdata.analytics.android.sdk.core.SACoreHelper;
import com.sensorsdata.analytics.android.sdk.data.persistent.PersistentLoader;
import com.sensorsdata.analytics.android.sdk.plugin.property.SAPropertyPlugin;
import com.sensorsdata.analytics.android.sdk.plugin.property.SAPropertyPluginPriority;
import com.sensorsdata.analytics.android.sdk.plugin.property.beans.SAPropertiesFetcher;
import com.sensorsdata.analytics.android.sdk.plugin.property.beans.SAPropertyFilter;
import com.sensorsdata.analytics.android.sdk.util.JSONUtils;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.common.WXModule;

import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;


public class WeexSensorsDataAnalyticsModule extends WXModule {

    private static final String MODULE_NAME = "WeexSensorsDataAnalyticsModule";
    private static final String LOGTAG = "SA.Weex";
    private String routerPath;
    private String routerTitle;

    /**
     * 导出 track 方法给 Weex 使用.
     * 代码埋点
     *
     * @param eventName 事件名称
     * @param properties 事件的具体属性
     * Weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.track("AddToFav",{"ProductID":123456,"UserLevel":"VIP"})
     */
    @JSMethod(uiThread = true)
    public void track(String eventName, HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().track(eventName, convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * Map 转换成 JSONObject
     */
    private JSONObject convertToJSONObject(HashMap<String, Object> properties) {
        JSONObject json = new JSONObject();
        if (properties == null) {
            return json;
        }
        for (String key : properties.keySet()) {
            if (key != null) {
                Object value = properties.get(key);
                if (value != null) {
                    try {
                        if (value instanceof com.alibaba.fastjson.JSONObject) {
                            json.put(key, new JSONObject(value.toString()));
                        } else {
                            json.put(key, value);
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return json;
    }

    /**
     * 导出 trackTimerStart 方法给 Weex 使用.
     * 初始化事件的计时器，默认计时单位为毫秒(计时开始).
     *
     * @param eventName 事件名称
     * weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.trackTimerStart("viewTimer")
     */
    @JSMethod(uiThread = true)
    public void trackTimerStart(String eventName) {
        try {
            SensorsDataAPI.sharedInstance().trackTimerStart(eventName);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 trackTimerEnd 方法给 Weex 使用.
     * 初始化事件的计时器，默认计时单位为毫秒(计时开始).
     *
     * @param eventName 事件名称
     * weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.trackTimerEnd("viewTimer")
     */
    @JSMethod(uiThread = true)
    public void trackTimerEnd(String eventName, HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().trackTimerEnd(eventName, convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 clearTrackTimer 方法给 Weex 使用.
     * 清除所有事件计时器
     * weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.clearTrackTimer()
     */
    @JSMethod(uiThread = true)
    public void clearTrackTimer() {
        try {
            SensorsDataAPI.sharedInstance().clearTrackTimer();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 login 方法给 Weex 使用.
     * 登录事件
     *
     * @param loginId 登录 ID
     * weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.login("developer@sensorsdata.cn")
     */
    @JSMethod(uiThread = true)
    public void login(String loginId) {
        try {
            SensorsDataAPI.sharedInstance().login(loginId);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 logout 方法给 Weex 使用.
     * 登出事件
     * weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.logout()
     */
    @JSMethod(uiThread = true)
    public void logout() {
        try {
            SensorsDataAPI.sharedInstance().logout();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 trackInstallation 方法给 Weex 使用.
     * 用于记录首次安装激活、渠道追踪的事件.
     *
     * @param eventName 事件名称
     * @param properties 事件的属性
     * weex 示例：
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.trackInstallation("AppInstall",{"$utm_source":"渠道A","$utm_campaign":"广告A"})
     */
    @JSMethod(uiThread = true)
    public void trackInstallation(String eventName, HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().trackInstallation(eventName, convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 trackViewScreen 方法给 Weex 使用.
     * weex 中 Tab 切换页面的时候调用，用于记录 $AppViewScreen 事件.
     *
     * @param url 页面的 url  记录到 $url 字段中(如果不需要此属性，可以传 null ).
     * @param properties 页面的属性.
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.trackViewScreen(null,{"$title":"主页","$screen_name":"cn.sensorsdata.demo.Home"})
     */
    @JSMethod(uiThread = true)
    public void trackViewScreen(String url, HashMap<String, Object> properties) {
        try {
            JSONObject convertProperties = convertToJSONObject(properties);
            SensorsDataAPI.sharedInstance().trackViewScreen(url, convertProperties);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 profileSet 方法给 Weex 使用.
     * 设置用户属性
     *
     * @param properties 用户属性
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.profileSet({"sex":"男"}))
     */
    @JSMethod(uiThread = true)
    public void profileSet(HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().profileSet(convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 profileSetOnce 方法给 Weex 使用.
     * 首次设置用户的一个或多个 Profile.
     * 与profileSet接口不同的是，如果之前存在，则忽略，否则，新创建.
     *
     * @param properties 属性列表
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.profileSetOnce({"sex":"男"}))
     */
    @JSMethod(uiThread = true)
    public void profileSetOnce(HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().profileSetOnce(convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 profileIncrement 方法给 Weex 使用.
     * 给一个数值类型的Profile增加一个数值. 只能对数值型属性进行操作，若该属性
     * 未设置，则添加属性并设置默认值为0.
     *
     * @param property 属性名称
     * @param value 属性的值，值的类型只允许为 Number.
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.profileIncrement("money",10)
     */
    @JSMethod(uiThread = true)
    public void profileIncrement(String property, Double value) {
        try {
            SensorsDataAPI.sharedInstance().profileIncrement(property, value);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 profileAppend 方法给 Weex 使用.
     * 给一个列表类型的 Profile 增加一个元素.
     *
     * @param property 属性名称.
     * @param value 新增的元素.
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.profileAppend("VIP","Gold")
     */
    @JSMethod(uiThread = true)
    public void profileAppend(String property, String value) {
        try {
            SensorsDataAPI.sharedInstance().profileAppend(property, value);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 profileUnset 方法给 Weex 使用.
     * 删除用户的一个 Profile.
     *
     * @param property 属性名称.
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.profileUnset("sex")
     */
    @JSMethod(uiThread = true)
    public void profileUnset(String property) {
        try {
            SensorsDataAPI.sharedInstance().profileUnset(property);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    /**
     * 导出 profileDelete 方法给 Weex 使用.
     * 删除用户所有 Profile.
     * weex 示例:
     * const modal = weex.requireModule('WeexSensorsDataAnalyticsModule')
     * modal.profileDelete()
     */
    @JSMethod(uiThread = true)
    public void profileDelete() {
        try {
            SensorsDataAPI.sharedInstance().profileDelete();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void deleteAll() {
        try {
            SensorsDataAPI.sharedInstance().deleteAll();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void trackTimerPause(String eventName) {
        try {
            SensorsDataAPI.sharedInstance().trackTimerPause(eventName);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void trackTimerResume(String eventName) {
        try {
            SensorsDataAPI.sharedInstance().trackTimerResume(eventName);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void registerApp(HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().registerSuperProperties(convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void unRegister(String superKey) {
        try {
            SensorsDataAPI.sharedInstance().unregisterSuperProperty(superKey);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void clearRegister() {
        try {
            SensorsDataAPI.sharedInstance().clearSuperProperties();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }


    @JSMethod(uiThread = true)
    public void flush() {
        try {
            SensorsDataAPI.sharedInstance().flush();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void identify(String distinctId) {
        try {
            SensorsDataAPI.sharedInstance().identify(distinctId);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void resetAnonymousId() {
        try {
            SensorsDataAPI.sharedInstance().resetAnonymousId();
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }


    @JSMethod(uiThread = true)
    public void setServerUrl(String serverUrl) {
        try {
            SensorsDataAPI.sharedInstance().setServerUrl(serverUrl);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void trackAppInstall(HashMap<String, Object> properties) {
        try {
            SensorsDataAPI.sharedInstance().trackAppInstall(convertToJSONObject(properties));
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void bind(String key, String value) {
        try {
            SensorsDataAPI.sharedInstance().bind(key, value);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void unbind(String key, String value) {
        try {
            SensorsDataAPI.sharedInstance().unbind(key, value);
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(LOGTAG, e.toString() + "");
        }
    }

    @JSMethod(uiThread = true)
    public void setProfile(HashMap<String, Object> properties) {
        profileSet(properties);
    }

    @JSMethod(uiThread = true)
    public void setOnceProfile(HashMap<String, Object> properties) {
        profileSetOnce(properties);
    }

    @JSMethod(uiThread = true)
    public void incrementProfile(String property, Double value) {
        profileIncrement(property, value);
    }

    @JSMethod(uiThread = true)
    public void appendProfile(String property, JSONArray value) {
        try {
            List values = JSONArray.parseArray(value.toJSONString(), String.class);
            if (values != null && !values.isEmpty()) {
                SensorsDataAPI.sharedInstance().profileAppend(property, new HashSet<String>(values));
            }
        } catch (Exception ignored) {

        }
    }

    @JSMethod(uiThread = true)
    public void unsetProfile(String property) {
        profileUnset(property);
    }

    @JSMethod(uiThread = true)
    public void deleteProfile(String property) {
        profileDelete();
    }

    @JSMethod(uiThread = true)
    public void handlePageChanged(HashMap<String, Object> properties) {

        if (checkSAVersion("6.4.3")) {
            SensorsDataAPI.sharedInstance().registerPropertyPlugin(WeexClickPlugin);
        }
        JSONObject convertProperties = convertToJSONObject(properties);
        if (isAutoTrackViewScreen()) {
            String url = convertProperties.optString("$screen_name");
            SensorsDataAPI.sharedInstance().trackViewScreen(url, convertProperties);
        }
        SACoreHelper.getInstance().trackQueueEvent(new Runnable() {
            @Override
            public void run() {
                routerPath = convertProperties.optString("$screen_name");
                routerTitle = convertProperties.optString("$title");
                if (TextUtils.isEmpty(routerTitle)) {
                    routerTitle = routerPath;
                }
            }
        });
    }

    @JSMethod(uiThread = true)
    public void initSDK(HashMap<String, Object> config) {
        try {
            JSONObject configJson = convertToJSONObject(config);
            SAConfigOptions saConfigOptions = new SAConfigOptions(configJson.optString("server_url"));
            saConfigOptions.enableLog(configJson.optBoolean("show_log"));
            JSONObject appConfig = configJson.optJSONObject("app");
            if (appConfig != null && appConfig.length() > 0) {
                int autoTrack = (appConfig.optBoolean("app_start", false) ? SensorsAnalyticsAutoTrackEventType.APP_START : 0) |
                        (appConfig.optBoolean("app_end", false) ? SensorsAnalyticsAutoTrackEventType.APP_END : 0) |
                        (appConfig.optBoolean("view_screen", false) ? SensorsAnalyticsAutoTrackEventType.APP_VIEW_SCREEN : 0) |
                        (appConfig.optBoolean("view_click", false) ? SensorsAnalyticsAutoTrackEventType.APP_CLICK : 0);
                saConfigOptions.setAutoTrackEventType(autoTrack);
                if (appConfig.optBoolean("javascript_bridge")) {
                    saConfigOptions.enableJavaScriptBridge(false);
                }
            }
            JSONObject superProperties = configJson.optJSONObject("super_properties");
            if (superProperties != null && superProperties.length() > 0 && checkSAVersion("6.4.3")) {
                saConfigOptions.registerPropertyPlugin(new SAPropertyPlugin() {
                    JSONObject mProperties = superProperties;

                    @Override
                    public boolean isMatchedWithFilter(SAPropertyFilter filter) {
                        return filter.getType().isTrack();
                    }

                    @Override
                    public void properties(SAPropertiesFetcher fetcher) {
                        if (mProperties == null || mProperties.length() == 0) {
                            return;
                        }
                        JSONObject properties = PersistentLoader.getInstance().getSuperPropertiesPst().get();
                        try {
                            JSONUtils.mergeSuperJSONObject(mProperties, properties);
                            PersistentLoader.getInstance().getSuperPropertiesPst().commit(properties);
                            mProperties = null;
                        } catch (Exception ignored) {
                        }
                    }

                    @Override
                    public SAPropertyPluginPriority priority() {
                        return SAPropertyPluginPriority.LOW;
                    }
                });
                saConfigOptions.registerPropertyPlugin(WeexClickPlugin);
            }
            SensorsDataAPI.startWithConfigOptions(mWXSDKInstance.getContext(), saConfigOptions);
            SALog.i(LOGTAG, "init success");
        } catch (Exception e) {
            SALog.i(LOGTAG, "SDK init failed:" + e.getMessage());
        }
    }

    public SAPropertyPlugin WeexClickPlugin = new SAPropertyPlugin() {
        @Override
        public boolean isMatchedWithFilter(SAPropertyFilter filter) {
            return "$AppClick".equals(filter.getEvent());
        }

        @Override
        public void properties(SAPropertiesFetcher fetcher) {
            if (!TextUtils.isEmpty(routerPath)) {
                try {
                    fetcher.getProperties().put("$screen_name", routerPath);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
            if (!TextUtils.isEmpty(routerTitle)) {
                try {
                    fetcher.getProperties().put("$title", routerTitle);
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }

        @Override
        public String getName() {
            return mWXSDKInstance.getInstanceId();
        }

        public SAPropertyPluginPriority priority() {
            return SAPropertyPluginPriority.HIGH;
        }
    };

    public static boolean checkSAVersion(final String requiredVersion) {
        try {
            SensorsDataAPI sensorsDataAPI = SensorsDataAPI.sharedInstance();
            Field field;
            if (sensorsDataAPI instanceof SensorsDataAPIEmptyImplementation) {
                field = sensorsDataAPI.getClass().getSuperclass().getDeclaredField("VERSION");
            } else {
                field = sensorsDataAPI.getClass().getDeclaredField("VERSION");
            }
            field.setAccessible(true);
            String version = (String) field.get(sensorsDataAPI);
            String compareVersion = version;
            if (!TextUtils.isEmpty(version)) {
                if (version.contains("-")) {
                    compareVersion = compareVersion.substring(0, compareVersion.indexOf("-"));
                }
                if (!isVersionValid(compareVersion, requiredVersion)) {
                    SALog.i(LOGTAG, "当前神策 Android 埋点 SDK 版本 " + version + " 过低，请升级至 " + requiredVersion + " 及其以上版本后进行使用");
                    return false;
                }
            }
        } catch (Exception ex) {
            SALog.printStackTrace(ex);
            return false;
        }
        return true;
    }

    /**
     * 比较当前实际的 SA 版本和期望的 SA 最低版本
     *
     * @param saVersion 当前实际的 SA 版本
     * @param requiredVersion 期望的 SA 最低版本
     * @return false 代表实际 SA 的比期望低，true 代表符合预期
     */
    public static boolean isVersionValid(String saVersion, String requiredVersion) {
        try {
            if (saVersion.equals(requiredVersion)) {
                return true;
            } else {
                String[] saVersions = saVersion.split("\\.");
                String[] requiredVersions = requiredVersion.split("\\.");
                for (int index = 0; index < requiredVersions.length; index++) {
                    int saVersionsNum = Integer.parseInt(saVersions[index]);
                    int requiredVersionsNum = Integer.parseInt(requiredVersions[index]);
                    if (saVersionsNum != requiredVersionsNum) {
                        return saVersionsNum > requiredVersionsNum;
                    }
                }
                return false;
            }
        } catch (Exception ex) {
            // ignore
            return false;
        }
    }

    @Override
    public void onActivityPause() {
        if (checkSAVersion("6.4.3")) {
            SensorsDataAPI.sharedInstance().unregisterPropertyPlugin(WeexClickPlugin);
        }
    }

    @Override
    public void onActivityResume() {
        if (isAutoTrackViewScreen() && !TextUtils.isEmpty(routerPath)) {
            JSONObject props = new JSONObject();
            try {
                props.put("$title", routerTitle);
                props.put("$screen_name", routerPath);
            } catch (JSONException ignored) {
            }
            SensorsDataAPI.sharedInstance().trackViewScreen(routerPath, props);
        }
    }

    public boolean isAutoTrackViewScreen() {
        return !SensorsDataAPI.sharedInstance().isAutoTrackEventTypeIgnored(SensorsDataAPI.AutoTrackEventType.APP_VIEW_SCREEN);
    }
}