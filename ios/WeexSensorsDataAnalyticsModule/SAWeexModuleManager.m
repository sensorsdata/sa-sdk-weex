//
// SAWeexModuleManager.m
// WeexSensorsDataAnalyticsModule
//
// Created by  储强盛 on 2023/7/20.
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

#import "SAWeexModuleManager.h"
#if __has_include(<SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>)
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#else
#import "SensorsAnalyticsSDK.h"
#endif

#import "SAWeexSwizzler.h"
#import "SAWeexViewClickPropertyPlugin.h"

@interface SAWeexModuleManager ()

@property (nonatomic, strong) SAWeexViewClickPropertyPlugin *viewClickPropertyPlugin;

@end


@implementation SAWeexModuleManager

+ (instancetype)sharedInstance {
    static SAWeexModuleManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SAWeexModuleManager alloc] init];
    });
    return manager;
}

- (void)registerViewClickPropertyPlugin {
    if(!self.viewClickPropertyPlugin) {
        self.viewClickPropertyPlugin = [[SAWeexViewClickPropertyPlugin alloc] initWithProperties:nil];
    }

    [SensorsAnalyticsSDK.sharedInstance registerPropertyPlugin:self.viewClickPropertyPlugin];
}

- (void)unregisterViewClickPropertyPlugin {
    if(!self.viewClickPropertyPlugin) {
        return;
    }

    [SensorsAnalyticsSDK.sharedInstance unregisterPropertyPluginWithPluginClass:[SAWeexViewClickPropertyPlugin class]];
    self.viewClickPropertyPlugin = nil;
}

- (void)updatePageProperties:(NSDictionary *)properties {
    // 更新属性插件的页面信息
    if(self.viewClickPropertyPlugin) {
        [self.viewClickPropertyPlugin updateProperties:properties];
    }

}

@end
