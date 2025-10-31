Pod::Spec.new do |s|
  s.name             = 'advanced_image_processing_toolkit'
  s.version          = '0.1.3'  # keep in sync with your plugin version
  s.summary          = 'Advanced image processing toolkit for Flutter'
  s.description      = <<-DESC
Advanced image processing, object recognition, and AR features for Flutter.
  DESC

  s.homepage         = 'https://github.com/hanan0007/advanced_image_processing'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'hanan0007' => 'you@example.com' }
  s.source           = { :path => '.' }

  s.platform         = :ios, '15.6'
  s.swift_version    = '5.0'
  s.static_framework = true

  s.dependency 'Flutter'

  # Your Swift/Obj-C files:
  s.source_files = 'Classes/**/*'
end
