Pod::Spec.new do |s|
  s.name         = "ZLSinusWaveView"
  s.version      = "0.0.1"
  s.summary      = "A Siri like voice visualization view using EZAudio. Modified from SISinusWaveView for iOS."
  s.description  = <<-DESC
                   A longer description of ZLSinusWaveView in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  s.homepage     = "https://github.com/zhxnlai/ZLSinusWaveView"
  s.screenshots  = "https://raw.githubusercontent.com/zhxnlai/ZLSinusWaveView/master/preview.gif"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author             = { "Zhixuan Lai" => "zhxnlai@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/zhxnlai/ZLSinusWaveView.git", :tag => "0.0.1" }
  s.source_files = "ZLSinusWaveView/*.{h,m}"
  s.requires_arc = true
  s.dependency "EZAudio", "~> 0.0.5"
end
