
Pod::Spec.new do |s|

  s.name         = "ENUUI"
  s.version      = "0.0.1"
  s.summary      = "show message to user."
  s.description  = <<-DESC
     sample code. just make a record of what I met while developing.
                   DESC

  s.author       = { "ENUUI" => "ey877302@gmail.com" }
  s.homepage     = "https://github.com/FuihuiC/"
  s.license      = "MIT"
  
  s.platform     = :ios
  s.platform     = :ios, "9.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/FuihuiC/ENUUI.git", :tag => "#{s.version}" }
  s.ios.source_files = 'ENUUI/**/*.swift'
  s.ios.resources = 'ENUUI/ENUUISource.bundle'
end
