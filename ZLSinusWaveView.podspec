Pod::Spec.new do |s|
  s.name         = "ZLSinusWaveView"
  s.version      = "0.0.3"
  s.summary      = "A Siri like voice visualization view using EZAudio. Modified from SISinusWaveView for iOS."
  s.description  = <<-DESC
                   A Siri like voice visualization view using EZAudio. Modified from [SISinusWaveView](https://github.com/raffael/SISinusWaveView) for iOS.
                   DESC
  s.homepage     = "https://github.com/zhxnlai/ZLSinusWaveView"
  s.screenshots  = "https://raw.githubusercontent.com/zhxnlai/ZLSinusWaveView/master/Previews/waveform.gif"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author       = { "Zhixuan Lai" => "zhxnlai@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/zhxnlai/ZLSinusWaveView.git", :tag => "0.0.3" }
  s.source_files = "ZLSinusWaveView/*.{h,m}"
  s.requires_arc = true
  s.dependency "EZAudio", "~> 0.0.6"
end
