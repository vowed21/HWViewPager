@version = "0.0.1"
Pod::Spec.new do |s|
  s.name         = "HWViewPager"
  s.version      = "0.0.1"
  s.summary      = "ViewPager , looks like Android's"
  s.homepage     = "https://github.com/vowed21/HWViewPager"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author       = { "HyunWoo Kim" => "hyunwoo-21@hanmail.net" }
  s.source       = { :git => "https://github.com/vowed21/HWViewPager.git", :tag => @version }
  s.source_files  = "HWViewPager/**/*.{h,m}"
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
end
