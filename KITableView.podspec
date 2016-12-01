Pod::Spec.new do |s|
  s.name         = "KITableView"
  s.version      = "0.0.1"
  s.summary      = "KITableView"

  s.description  = <<-DESC
                   KITableView.
                   DESC

  s.homepage     = "https://github.com/smartwalle/KITableView"
  s.license      = "MIT"
  s.author       = { "SmartWalle" => "smartwalle@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/smartwalle/KITableView.git", :tag => "#{s.version}" }
  s.source_files = "KITableView/KITableView/**/*.{h,m}"
  s.requires_arc = true
end
