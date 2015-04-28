Pod::Spec.new do |s|
  s.name         = "LHMaterialDesign"
  s.version      = "1.0.0"
  s.summary      = "UIViewController's Transition with Material Design"
  s.description  = <<-DESC
                    UIViewController's Transition with Material Design  实现UIViewController切换时Material Design的效果
                   DESC
  s.homepage     = "https://github.com/leostc/LHMaterialDesign"
  
  s.license      = 'MIT'
  s.author       = { "LiHao" => "zjhzlihao@126.com" }
  s.social_media_url = "https://twitter.com/lihao_china"
  s.source       = { :git => "https://github.com/leostc/LHMaterialDesign.git", :tag => s.version }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'LHMaterialDesign/MaterialDesign/*'
  s.frameworks = 'Foundation', 'UIKit'
end
