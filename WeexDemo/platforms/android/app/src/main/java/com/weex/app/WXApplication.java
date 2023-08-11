package com.weex.app;

import android.app.Application;
import android.util.Log;

import com.weex.app.extend.ImageAdapter;
import com.weex.app.WeexSensorsDataAnalyticsModule;
import com.weex.app.extend.WXEventModule;
import com.alibaba.weex.plugin.loader.WeexPluginContainer;
import com.weex.app.util.AppConfig;
import com.taobao.weex.InitConfig;
import com.taobao.weex.WXSDKEngine;
import com.taobao.weex.common.WXException;
import com.sensorsdata.analytics.android.sdk.SAConfigOptions;
import com.sensorsdata.analytics.android.sdk.SensorsAnalyticsAutoTrackEventType;
import com.sensorsdata.analytics.android.sdk.SensorsDataAPI;

public class WXApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
//        initSensorsDataAPI();
        WXSDKEngine.addCustomOptions("appName", "WXSample");
        WXSDKEngine.addCustomOptions("appGroup", "WXApp");
        WXSDKEngine.initialize(this,
                new InitConfig.Builder().setImgAdapter(new ImageAdapter()).build()
        );
        try {
            WXSDKEngine.registerModule("event", WXEventModule.class);
            WXSDKEngine.registerModule("WeexSensorsDataAnalyticsModule", WeexSensorsDataAnalyticsModule.class);
        } catch (WXException e) {
            e.printStackTrace();
        }
        AppConfig.init(this);
        WeexPluginContainer.loadAll(this);
    }

    /**
     * 初始化 Sensors Analytics SDK
     */
    private void initSensorsDataAPI() {
        SAConfigOptions configOptions = new SAConfigOptions("");
        // 打开自动采集, 并指定追踪哪些 AutoTrack 事件
        configOptions.setAutoTrackEventType(SensorsAnalyticsAutoTrackEventType.APP_START |
                SensorsAnalyticsAutoTrackEventType.APP_END |
                SensorsAnalyticsAutoTrackEventType.APP_CLICK |
                SensorsAnalyticsAutoTrackEventType.APP_VIEW_SCREEN);
        // 打开 crash 信息采集
        configOptions.enableTrackAppCrash().enableLog(true);
        //传入 SAConfigOptions 对象，初始化神策 SDK
        SensorsDataAPI.startWithConfigOptions(this, configOptions);
        SensorsDataAPI.sharedInstance().trackFragmentAppViewScreen();
    }
}
