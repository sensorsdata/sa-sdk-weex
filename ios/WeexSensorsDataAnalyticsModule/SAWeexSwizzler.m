//
// SAWeexSwizzler.m
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

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "UIViewController+SAWeex.h"
#import "SAWeexSwizzler.h"


@implementation SAWeexSwizzler

+ (void)swizzleViewDidAppear {

    [UIViewController sensors_weex_swizzle:@selector(viewDidAppear:) withSelector:@selector(sensors_weex_viewDidAppear:)];

    [UIViewController sensors_weex_swizzle:@selector(viewDidDisappear:) withSelector:@selector(sensors_weex_viewDidDisappear:)];
}

@end


@implementation NSObject (SAWeexSwizzler)


+ (BOOL)sensors_weex_swizzle:(SEL)originalSelector withSelector:(SEL)destinationSelector {
    Method origMethod = class_getInstanceMethod(self, originalSelector);
    if (!origMethod) {
        return NO;
    }

    Method altMethod = class_getInstanceMethod(self, destinationSelector);
    if (!altMethod) {
        return NO;
    }

    //为了避免获取的是父类的方法
    class_addMethod(self,
                    originalSelector,
                    class_getMethodImplementation(self, originalSelector),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    destinationSelector,
                    class_getMethodImplementation(self, destinationSelector),
                    method_getTypeEncoding(altMethod));

    method_exchangeImplementations(class_getInstanceMethod(self, originalSelector), class_getInstanceMethod(self, destinationSelector));
    return YES;
}

@end






