Pod::Spec.new do |s|
  s.name             = 'ShopHome'
  s.version          = '1.0.0'
  s.summary          = '首页业务组件'
  s.description      = 'ShopHome provides HomeViewController, HomeViewModel, banner/category cells, Target_Home, and route registration for the home flow.'
  s.homepage         = 'https://github.com/inhua/ShopHome'
  s.license          = { :type => 'MIT' }
  s.author           = { 'inhua' => 'dev@inhua.com' }
  s.source           = { :git => 'https://github.com/inhua/ShopHome.git', :tag => s.version.to_s }

  s.platform              = :ios, '18.1'
  s.swift_version         = '5.0'

  s.source_files = 'Sources/**/*.swift'

  s.resource_bundles = {
    'ShopHome_Resources' => ['Resources/**/*']
  }

  s.dependency 'ShopBase'
  s.dependency 'ShopRouter'
  s.dependency 'ShopMediator'
  s.dependency 'ShopProduct'
end
