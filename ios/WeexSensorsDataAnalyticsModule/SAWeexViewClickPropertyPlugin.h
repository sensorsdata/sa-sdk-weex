//
// SAWeexViewClickPropertyPlugin.h
// WeexSensorsDataAnalyticsModule
//
// Created by  储强盛 on 2023/7/17.
// Copyright © 2015-2023 Sensors Data Co., Ltd. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#if __has_include(<SensorsAnalyticsSDK/SAPropertyPlugin.h>)
#import <SensorsAnalyticsSDK/SAPropertyPlugin.h>
#else
#import "SAPropertyPlugin.h"
#endif

NS_ASSUME_NONNULL_BEGIN

/// Weex 元素点击全埋点属性插件，用于采集页面信息
@interface SAWeexViewClickPropertyPlugin : SAPropertyPlugin

/// Weex 元素点击属性插件
///
/// 用于监听页面路由跳转后，获取页面信息，并注入到 $AppClick 全埋点事件中
///
/// @param properties 页面信息属性
- (instancetype)initWithProperties:(nullable NSDictionary *)properties NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/// 更新插件中的属性
- (void)updateProperties:(NSDictionary *)properties;

@end

NS_ASSUME_NONNULL_END
