//
// UIViewController+SAWeex.m
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

#import "UIViewController+SAWeex.h"
#import "SAWeexSwizzler.h"
#import "SAWeexModuleManager.h"

@implementation UIViewController (SAWeex)

+ (void)load {
    [SAWeexSwizzler swizzleViewDidAppear];
}

- (void)sensors_weex_viewDidAppear:(BOOL)animated {
    [self sensors_weex_viewDidAppear:animated];

    if(SAWeexModuleManager.sharedInstance.weexInstance.viewController != self){
        return;
    }

    /* 宿主页面出现
     需要注册属性插件，获取路由切换获取到的 weex 层的当前页面信息
     */
    [SAWeexModuleManager.sharedInstance registerViewClickPropertyPlugin];

}

- (void)sensors_weex_viewDidDisappear:(BOOL)animated {

    [self sensors_weex_viewDidDisappear:animated];

    if(SAWeexModuleManager.sharedInstance.weexInstance.viewController != self){
        return;
    }
    
    // weex 宿主页面消失
    [SAWeexModuleManager.sharedInstance unregisterViewClickPropertyPlugin];
}
@end
