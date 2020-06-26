Pod::Spec.new do |s|
  s.name             = 'MKDatePicker'
  s.version          = '1.1.0'
  s.summary          = 'A short description of MKDatePicker.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LiuSky/MKDatePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/LiuSky/MKDatePicker.git', :tag => s.version.to_s }

  
  s.swift_version         = '5.0'
  s.ios.deployment_target = '9.0'
  s.source_files  = "MKDatePicker/Classes/Controller/", "MKDatePicker/Classes/Extension/", "MKDatePicker/Classes/Model/", "MKDatePicker/Classes/View/", "MKDatePicker/Classes/Protocol/"
  s.resources = 'MKDatePicker/Assets/Langs.bundle'
  
  s.dependency 'XBAlertViewController', '~> 1.0.1'
end
