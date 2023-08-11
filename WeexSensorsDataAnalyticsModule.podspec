Pod::Spec.new do |s|
  s.name         = "WeexSensorsDataAnalyticsModule"
  s.version      = "1.0.0"
  s.summary      = "The official Weex SDK of Sensors Analytics."
  s.description  = <<-DESC
                  神策分析 Weex 组件
                   DESC
  s.homepage     = "http://www.sensorsdata.cn"
  s.license = { :type => "Apache License, Version 2.0" }
  s.author = { "QiangSheng Chu" => "chuqiangsheng@sensorsdata.cn" }
  s.platform = :ios, "9.0"
  s.source       = { :git => 'https://github.com/sensorsdata/sa-sdk-weex.git', :tag => "v#{s.version}" }
  s.source_files = "ios/WeexSensorsDataAnalyticsModule/*.{h,m}"
  s.public_header_files = "ios/WeexSensorsDataAnalyticsModule/WeexSensorsDataAnalyticsModule.h"
  s.requires_arc = true
  s.dependency "SensorsAnalyticsSDK", ">= 4.4.1"
  # WeexPluginLoader.framework only supports x86_64 simulators.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }

end
