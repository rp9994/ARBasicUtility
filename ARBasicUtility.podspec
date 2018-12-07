Pod::Spec.new do |s|
  s.name             = 'ARBasicUtility'
  s.version          = '0.1.3'
  s.summary          = 'For the fast developing the apps some useful utility'
  s.swift_version    = '4.2'
  s.description      = <<-DESC
For the fast developing the apps some useful utility!
                       DESC
 
  s.homepage         = 'https://github.com/rp9994/ARBasicUtility/tree/master/ARBasicUtility'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ronak Adeshara' => 'r.p.soni321@gmail.com' }
  s.source           = { :git => 'https://github.com/rp9994/ARBasicUtility.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.0'
  s.source_files = 'ARBasicUtility/tree/master/ARBasicUtility/ARUtilities/*.{swift}'
  s.dependency 'Alamofire'
  s.dependency 'IQKeyboardManager'
  s.dependency 'KRProgressHUD'
  s.dependency 'ObjectMapper' 
  s.dependency 'SDWebImage'
end