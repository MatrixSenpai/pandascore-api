Pod::Spec.new do |s|
  s.name = "PandaScoreAPI"
  s.version = "1.0.0"
  s.summary = "API lib for PandaScore used in Syqen"

  s.homepage = "https://github.com/matrixsenpai/pandascore-api"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Mason Phillips" => "math.matrix@icloud.com" }

  s.source = { :git => "https://github.com/matrixsenpai/panda-api.git", :tag => s.version.to_s }

  s.ios.deployment_target = "12.0"

  s.source_files = "Sources/panda-api/**/*.swift"
  s.dependency "RxSwift"
  s.swift_version = "5.0"
end
