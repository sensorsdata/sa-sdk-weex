//
// SAWeexViewClickPropertyPlugin.m
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

#if ! __has_feature(objc_arc)
#error This file must be compiled with ARC. Either turn on ARC for the project or use -fobjc-arc flag on this file.
#endif

#import "SAWeexViewClickPropertyPlugin.h"

@interface SAWeexViewClickPropertyPlugin()
@property (nonatomic, copy) NSDictionary<NSString *, id> *pageProperties;
@end

@implementation SAWeexViewClickPropertyPlugin

- (instancetype)initWithProperties:(NSDictionary *)properties {
    self = [super init];
    if (self) {
        self.pageProperties = properties;
    }
    return self;
}

- (BOOL)isMatchedWithFilter:(id<SAPropertyPluginEventFilter>)filter {
    // 只有全埋点触发的 @"$AppClick" 事件，才需要采集页面信息
    if([filter.event isEqualToString:@"$AppClick"] && [filter.lib.method isEqualToString:@"autoTrack"]) {
        return YES;
    }
    // 支持 track、Signup、Bind、Unbind
    return  NO;
}

- (SAPropertyPluginPriority)priority {
    return SAPropertyPluginPriorityDefault;
}

- (NSDictionary<NSString *,id> *)properties {
    return [self.pageProperties copy];
}

/// 更新插件中的属性
- (void)updateProperties:(NSDictionary *)properties {
    self.pageProperties = properties;
}

@end
