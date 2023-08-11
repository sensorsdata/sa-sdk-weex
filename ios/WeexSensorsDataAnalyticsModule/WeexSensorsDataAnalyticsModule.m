//
// WeexSensorsDataAnalyticsModule.m
// WeexSensorsDataAnalyticsModule
//
// Created by  储强盛 on 2023/7/14.
// Copyright © 2015-2023 Sensors Data Co., Ltd. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag on this file.
#endif

#if __has_include(<SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>)
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#else
#import "SensorsAnalyticsSDK.h"
#endif

#import "WeexSensorsDataAnalyticsModule.h"

#import "SAWeexModuleManager.h"


#pragma mark - Constants
NSString *const kSAEventScreenNameProperty = @"$screen_name";
NSString *const kSAEventTitleProperty = @"$title";

@interface WeexSensorsDataAnalyticsModule()


@end

@implementation WeexSensorsDataAnalyticsModule

@synthesize weexInstance;

- (instancetype)init {
    self = [super init];
    if (self) {
        SAWeexModuleManager.sharedInstance.weexInstance = weexInstance;
        /* 注册 Module 后，默认注册属性插件
         此时宿主页面已加载，viewDidDisappear 已经执行结束
        */
        [SAWeexModuleManager.sharedInstance registerViewClickPropertyPlugin];
    }
    return self;
}

#pragma mark - SDK config

WX_EXPORT_METHOD(@selector(initSDK:))
/*
 server_url:’数据接收地址‘,
 show_log:true,//是否开启日志
 super_properties: {name1: 'value1'}, // 配置全局属性，所有上报事件属性中均会携带， web 通过 registerPage 实现
 app:{  // Android & iOS 初始化配置
    // app weex 扩展翻译为 app sdk 枚举
    app_start: true|false,
    app_end: true|false,
    view_screen: true|false,
    view_click: true|false

    // 全埋点开关，默认不开启
    javascript_bridge?: boolean, //H5 打通开关，默认 false
    }
 }
 */

/**
 根据配置初始化 SDK

 @param config 初始化参数
*/
- (void)initSDK:(NSDictionary *)config {

    if (![config isKindOfClass:[NSDictionary class]]) {
        return;
    }

    NSString *serverURL = config[@"server_url"];
    if (![serverURL isKindOfClass:[NSString class]]) {
        return;
    }

    // 初始化配置
    SAConfigOptions *configOptions = [[SAConfigOptions alloc] initWithServerURL:serverURL launchOptions:nil];

    NSNumber *enableLog = config[@"show_log"];
    if ([enableLog isKindOfClass:[NSNumber class]]) {
        configOptions.enableLog = [enableLog boolValue];
    }

    // 解析公共属性
    NSDictionary *superProperties = config[@"super_properties"];

    /********  App 特有配置解析  ********/
    NSDictionary *appConfig = config[@"app"];
    if (![appConfig isKindOfClass:[NSDictionary class]]) {
        [SensorsAnalyticsSDK startWithConfigOptions:configOptions];

        if ([superProperties isKindOfClass:[NSDictionary class]] && superProperties.count > 0) {
            [SensorsAnalyticsSDK.sharedInstance registerSuperProperties:superProperties];
        }
        return;
    }

    // 全埋点配置解析
    SensorsAnalyticsAutoTrackEventType autoTrackEventType = 0;
    NSNumber *appStart = appConfig[@"app_start"];
    if ([appStart isKindOfClass:[NSNumber class]] && [appStart boolValue]) {
        autoTrackEventType = autoTrackEventType | SensorsAnalyticsEventTypeAppStart;
    }

    NSNumber *appEnd = appConfig[@"app_end"];
    if ([appEnd isKindOfClass:[NSNumber class]] && [appEnd boolValue]) {
        autoTrackEventType = autoTrackEventType | SensorsAnalyticsEventTypeAppEnd;
    }
    NSNumber *viewCcreen = appConfig[@"view_screen"];
    if ([viewCcreen isKindOfClass:[NSNumber class]] && [viewCcreen boolValue]) {
        autoTrackEventType = autoTrackEventType | SensorsAnalyticsEventTypeAppViewScreen;
    }
    NSNumber *viewClick = appConfig[@"view_click"];
    if ([viewClick isKindOfClass:[NSNumber class]] && [viewClick boolValue]) {
        autoTrackEventType = autoTrackEventType | SensorsAnalyticsEventTypeAppClick;
    }

    configOptions.autoTrackEventType = autoTrackEventType;

    // 开启 SDK
    [SensorsAnalyticsSDK startWithConfigOptions:configOptions];

    // 注册公共属性
    if ([superProperties isKindOfClass:[NSDictionary class]] && superProperties.count > 0) {
        [SensorsAnalyticsSDK.sharedInstance registerSuperProperties:superProperties];
    }
}

WX_EXPORT_METHOD(@selector(setServerUrl:))
/**
 * 设置当前 serverUrl
 *
 * @param serverUrl 当前 serverUrl : string
 */
- (void)setServerUrl:(NSString *)serverUrl {
    [[SensorsAnalyticsSDK sharedInstance] setServerUrl:serverUrl];
}

#pragma mark - track
WX_EXPORT_METHOD(@selector(track:withProperties:))
/**
 * 导出 track 方法给 weex 使用.
 *
 * @param event  事件名称
 * @param propertyDict 事件的具体属性
 *
 * weex 中使用示例：
 *            weexSensorsAnalyticsModule.track("weex_AddToFav",{"ProductID":123456,"UserLevel":"VIP"})
 */
- (void)track:(NSString *)event withProperties:(NSDictionary *)propertyDict {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] track:event withProperties:propertyDict];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(trackTimerStart:))
/**
 * 导出 trackTimer 方法给 weex 使用.
 *
 * 初始化事件的计时器，默认计时单位为毫秒(计时开始).
 * @param event  事件名称或事件的 eventId
 *
 *  weex 中使用示例：（计时器事件名称 viewTimer ）
 *            weexSensorsAnalyticsModule.trackTimerStart("viewTimer")
 *            weexSensorsAnalyticsModule.trackTimerEnd("viewTimer")
 */
- (void)trackTimerStart:(NSString *)event {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] trackTimerStart:event];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(trackTimerEnd:))
/**
 结束事件计时

 @discussion
 多次调用 trackTimerEnd: 时，以首次调用为准

 @param event 事件名称或事件的 eventId
 */
- (void)trackTimerEnd:(NSString *)event {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] trackTimerEnd:event];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(clearTrackTimer))
/**
 * 导出 clearTrackTimer 方法给 weex 使用.
 * <p>
 * 清除所有事件计时器
 * <p>
 * weex 中使用示例：
 *                 weexSensorsAnalyticsModule.clearTrackTimer()
 */
- (void)clearTrackTimer {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] clearTrackTimer];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(trackTimerPause:))
/// 暂停事件计时
///
/// @param event  事件名称或事件的 eventId
- (void)trackTimerPause:(NSString *)event {
    [SensorsAnalyticsSDK.sharedInstance trackTimerPause:event];
}

WX_EXPORT_METHOD(@selector(trackTimerResume:))
/// 恢复事件计时
///
/// @param event  事件名称或事件的 eventId
- (void)trackTimerResume:(NSString *)event {
    [SensorsAnalyticsSDK.sharedInstance trackTimerResume:event];
}


WX_EXPORT_METHOD(@selector(trackInstallation:withProperties:))
/**
 * 导出 trackInstallation 方法给 weex 使用.
 *
 * 用于记录首次安装激活、渠道追踪的事件.
 * @param event  事件名.
 * @param propertyDict 事件属性.
 *
 *  weex 中使用示例：
 *            const date = new Date();
 *            this.year = date.getFullYear();
 *            this.month = date.getMonth() + 1;
 *            this.date = date.getDate();
 *            this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
 *            this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
 *            this.second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
 *            var currentTime =  this.year + "-" + this.month + "-" + this.date + " " + this.hour
 *                               + ":" + this.minute + ":" + this.second;
 *            weexSensorsAnalyticsModule.trackInstallation("AppInstall",{"FirstUseTime":currentTime})
 */
- (void)trackInstallation:(NSString *)event withProperties:(NSDictionary *)propertyDict {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] trackInstallation:event withProperties:propertyDict];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(trackAppInstall:))
/**
 * 记录 $AppInstall 事件，用于在 App 首次启动时追踪渠道来源，并设置追踪渠道事件的属性。
 *
 * 这是 Sensors Analytics 进阶功能，请参考文档 https://sensorsdata.cn/manual/track_installation.html
 *
 * @param properties 激活事件的属性
 */
- (void)trackAppInstall:(NSDictionary *)properties {
    [[SensorsAnalyticsSDK sharedInstance] trackAppInstallWithProperties:properties];
}

WX_EXPORT_METHOD(@selector(trackViewScreen:withProperties:))
/**
 * 导出 trackViewScreen 方法给 weex 使用.
 *
 * 此方法用于 weex 中 Tab 切换页面的时候调用，用于记录 $AppViewScreen 事件.
 *
 * @param url        页面的 url  记录到 $url 字段中(如果不需要此属性，可以传 null ).
 * @param properties 页面的属性.
 *
 * 注：为保证记录到的 $AppViewScreen 事件和 Auto Track 采集的一致，
 *    需要传入 $title（页面的title） 、$screen_name （页面的名称，即 包名.类名）字段.
 *
 * weex 中使用示例：
 *            weexSensorsAnalyticsModule.trackViewScreen(null,{"$title":"weex主页","$screen_name":"cn.sensorsdata.demo.weexHome"})
 */
- (void)trackViewScreen:(NSString *)url withProperties:(NSDictionary *)properties {
    @try {
            [[SensorsAnalyticsSDK sharedInstance] trackViewScreen:url withProperties:properties];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(handlePageChanged:))
/// 页面发生变化回调
///
/// 内部使用，用于触发页面浏览全埋点和 $AppClick 全埋点采集当前页面信息
///
/// @param properties 页面相关属性，包含 $screen_name 和 $title
- (void)handlePageChanged:(NSDictionary *)properties {
    @try {

        NSString *screenName = properties[kSAEventScreenNameProperty];
        NSString *title = properties[kSAEventTitleProperty] ?: screenName;

        NSMutableDictionary *pageProperties = [NSMutableDictionary dictionary];
        pageProperties[kSAEventScreenNameProperty] = screenName;
        pageProperties[kSAEventTitleProperty] = title;

        [SAWeexModuleManager.sharedInstance updatePageProperties:pageProperties];

        // 开启页面浏览全埋点
        if(![SensorsAnalyticsSDK.sharedInstance isAutoTrackEventTypeIgnored:SensorsAnalyticsEventTypeAppViewScreen]) {

            NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:properties];
            result[@"$lib_method"] = @"autoTrack";

            [[SensorsAnalyticsSDK sharedInstance] trackViewScreen:screenName withProperties:result];
        }
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(flush))
/// 立即把数据传到对应的 SensorsAnalytics 服务器上
- (void)flush {
    [SensorsAnalyticsSDK.sharedInstance flush];
}


WX_EXPORT_METHOD(@selector(registerApp:))
/// 注册公共属性
///
/// @param properties 需要注册的公共属性内容
- (void)registerApp:(NSDictionary *)properties {
    if (![properties isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [SensorsAnalyticsSDK.sharedInstance registerSuperProperties:properties];
}

WX_EXPORT_METHOD(@selector(unRegister:))
/// 清除某个公共属性
- (void)unRegister:(NSString *)property {
    [SensorsAnalyticsSDK.sharedInstance unregisterSuperProperty:property];
}

WX_EXPORT_METHOD(@selector(clearRegister))
/// 清除所有公共属性
- (void)clearRegister {
    [SensorsAnalyticsSDK.sharedInstance clearSuperProperties];
}

WX_EXPORT_METHOD(@selector(deleteAll))
/// 删除本地缓存的全部事件
///
/// 一旦调用该接口，将会删除本地缓存的全部事件，请慎用！
- (void)deleteAll {
    [SensorsAnalyticsSDK.sharedInstance deleteAll];
}

#pragma mark - login
WX_EXPORT_METHOD(@selector(login:))
/**
 * 导出 login 方法给 weex 使用.
 *
 * @param loginId 用户唯一下登录ID
 *
 * weex 中使用示例：
 *            weexSensorsAnalyticsModule.login("developer@sensorsdata.cn")
 */
- (void)login:(NSString *)loginId {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] login:loginId];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(logout))
/**
 * 导出 logout 方法给 weex 使用.
 *
 * weex 中使用示例：
 *            weexSensorsAnalyticsModule.logout()
 */
- (void)logout {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] logout];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(identify:))
/// 重置当前用户的匿名 ID
///
/// @param anonymousId 当前用户的 anonymousId
- (void)identify:(NSString *)anonymousId {
    [SensorsAnalyticsSDK.sharedInstance identify:anonymousId];
}

WX_EXPORT_METHOD(@selector(resetAnonymousId))
/// 重置默认匿名 id
- (void)resetAnonymousId {
    [SensorsAnalyticsSDK.sharedInstance resetAnonymousId];
}



#pragma mark IDMaping - 3.0

WX_EXPORT_METHOD(@selector(bind: value:))
/**
 @abstract
 ID-Mapping 3.0 功能下绑定业务 ID 功能

 @param key 绑定业务 ID 的键名
 @param value 绑定业务 ID 的键值
 */
- (void)bind:(NSString *)key value:(NSString *)value {
    [SensorsAnalyticsSDK.sharedInstance bind:key value:value];
}

WX_EXPORT_METHOD(@selector(unbind: value:))
/**
 @abstract
 ID-Mapping 3.0 功能下解绑业务 ID 功能

 @param key 解绑业务 ID 的键名
 @param value 解绑业务 ID 的键值
 */

- (void)unbind:(NSString *)key value:(NSString *)value {
    [SensorsAnalyticsSDK.sharedInstance unbind:key value:value];
}

WX_EXPORT_METHOD(@selector(loginWithKey: loginId:))
/**
 ID-Mapping 3.0 登录，设置当前用户的 loginIDKey 和 loginId

 ⚠️ 此接口为 ID-Mapping 3.0 特殊场景下特定接口，请咨询确认后再使用

 @param key 当前用户的登录 ID key
 @param loginId 当前用户的登录 ID
 */
- (void)loginWithKey:(NSString *)key loginId:(NSString *)loginId {
    [SensorsAnalyticsSDK.sharedInstance loginWithKey:key loginId:loginId];
}


#pragma mark - Profile
WX_EXPORT_METHOD(@selector(setProfile:))
/**
 * 导出 setProfile 方法给 weex 使用.
 *
 * @param profileDict 用户属性
 *
 * weex 中使用示例：（保存用户的属性 "sex":"男"）
 *            weexSensorsAnalyticsModule.setProfile({"sex":"男"})
 */
- (void)setProfile:(NSDictionary *)profileDict {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] set:profileDict];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(setOnceProfile:))
/**
 * 导出 setOnceProfile 方法给 weex 使用.
 *
 * 首次设置用户的一个或多个 Profile.
 * 与set接口不同的是，如果之前存在，则忽略，否则，新创建.
 *
 * @param profileDict 属性列表
 *
 *  weex 中使用示例：（保存用户的属性 "sex":"男"）
 *            weexSensorsAnalyticsModule.setOnceProfile({"sex":"男"})
 */
- (void)setOnceProfile:(NSDictionary *)profileDict {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] setOnce:profileDict];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(unsetProfile:))
/**
 * 导出 unsetProfile 方法给 weex 使用.
 * <p>
 * 删除用户的一个 Profile.
 *
 * @param profile Profile 的名称
 *                 <p>
 *                 weex 中使用示例：
 *                 weexSensorsAnalyticsModule.unsetProfile("sex")
 */
- (void)unsetProfile:(NSString *)profile {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] unset:profile];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(incrementProfile:value:))
/**
 * 导出 incrementProfile 方法给 weex 使用.
 *
 * 给一个数值类型的Profile增加一个数值. 只能对数值型属性进行操作，若该属性
 * 未设置，则添加属性并设置默认值为0.
 *
 * @param profile 待增加数值的 Profile 的名称
 * @param value    要增加的数值，值的类型只允许为 Number .
 *
 * weex 中使用示例：
 *            weexSensorsAnalyticsModule.incrementProfile("money",10)
 */
- (void)incrementProfile:(NSString *)profile value:(NSNumber *)value {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] increment:profile by:value];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(appendProfile:value:))
/**
 * 导出 appendProfile 方法给 weex 使用.
 * <p>
 * 向一个<code>NSSet</code>类型的value添加一些值
 *
 * @param profile Profile 的名称
 * @param content   Profile 的内容
 *                 <p>
 * weex 中使用示例：
 *                   var list = ["Sicario","Love Letter"];
 *                   weexSensorsAnalyticsModule.appendProfile("Move",list)

 */
- (void)appendProfile:(NSString *)profile value:(NSArray *)content {
    @try {
        NSSet *setCntent = [NSSet setWithArray:content];
        [[SensorsAnalyticsSDK sharedInstance] append:profile by:setCntent];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

WX_EXPORT_METHOD(@selector(deleteProfile))
/**
 * 导出 deleteProfile 方法给 weex 使用.
 * <p>
 * 删除当前这个用户的所有记录.
 * <p>
 * weex 中使用示例：
 *                weexSensorsAnalyticsModule.deleteProfile()
 */
- (void)deleteProfile {
    @try {
        [[SensorsAnalyticsSDK sharedInstance] deleteUser];
    } @catch (NSException *exception) {
        NSLog(@"[weexSensorsAnalytics] error:%@",exception);
    }
}

@end
