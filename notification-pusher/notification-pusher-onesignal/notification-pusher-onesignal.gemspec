# -*- encoding: utf-8 -*-
version = File.read(File.expand_path('../../VERSION', __dir__)).strip

Gem::Specification.new do |gem|
    gem.name                  = 'notification-pusher-onesignal'
    gem.version               = version
    gem.platform              = Gem::Platform::RUBY
    gem.summary               = 'A pusher to send cross-platform notifications with OneSignal'
    gem.description           = 'A pusher to send cross-platform notifications with OneSignal.'
    gem.authors               = 'Jonas Hübotter'
    gem.email                 = 'jonas.huebotter@gmail.com'
    gem.homepage              = 'https://github.com/jonhue/notifications-rails/tree/master/notification-pusher/notification-pusher-onesignal'
    gem.license               = 'MIT'

    gem.files                 = Dir['README.md', 'CHANGELOG.md', 'LICENSE', 'lib/**/*']
    gem.require_paths         = ['lib']

    gem.required_ruby_version = '>= 2.3'

    gem.add_dependency 'railties', '>= 5.0'
    gem.add_dependency 'one_signal', '~> 1.2'
    gem.add_dependency 'notification-pusher', version

    gem.add_development_dependency 'rspec', '~> 3.7'
    gem.add_development_dependency 'rubocop', '~> 0.52'
end
