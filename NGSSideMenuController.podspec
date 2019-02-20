_release = "0.6"
_build = "0"

_version = _release + "." + _build #e.x. 1.2.3
_tag = "R" + _release + "/" + _version #e.x. R1.2/1.2.3

Pod::Spec.new do |s|
  s.name             = 'NGSSideMenuController'
  s.version          = _version
  s.summary          = 'Side menu controller for popup items'

  s.description      = 'Framework to make nicely animated side menus'

  s.homepage         = 'https://github.com/PauliusVindzigelskis/NGSSideMenuController'
#s.screenshot       = 'https://user-images.githubusercontent.com/2383901/33856667-70c34d46-de8e-11e7-9ece-945037ca00de.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Paulius Vindzigelskis' => 'p.vindzigelskis@gmail.com' }
  s.source           = { :git => 'https://github.com/PauliusVindzigelskis/NGSSideMenuController.git', :tag => _tag }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Library/**/*.{h,m}'
  s.public_header_files = 'Library/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Masonry'
end
