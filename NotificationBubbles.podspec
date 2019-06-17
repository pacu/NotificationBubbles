Pod::Spec.new do |s|
  s.name             = 'NotificationBubbles'
  s.version          = '1.0.0'
  s.summary          = 'Straight out-of-the-box notification bubbles'

  s.description      = <<-DESC
            Just a rounded bubble to show text for an instant
                       DESC

  s.homepage         = 'https://github.com/pacu/NotificationBubbles'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Francisco Gindre' => 'francisco.gindre@gmail.com' }
  s.source           = { :git => 'https://github.com/pacu/NotificationBubbles.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'
  s.source_files = 'Sources/**/*.swift'
end
