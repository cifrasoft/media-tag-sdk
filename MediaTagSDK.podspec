
Pod::Spec.new do |s|
  s.name = 'MediaTagSDK'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'MediaTagSDK framework'
  s.homepage = 'https://github.com/cifrasoft/media-tag-sdk-ios/'
  s.authors = { 'miromax21' => 'miromax21@gmail.com' }
  
  s.source = { :git => 'https://github.com/cifrasoft/media-tag-sdk-ios/', :tag => s.version.to_s }
  s.source_files = 'Sources/*.swift', 'Sources/extentions/*.swift', 'Sources/models/*.swift', 'Sources/NS/*.swift'
  s.swift_version = '5.0'
  s.platform = :ios, '13.0'

end