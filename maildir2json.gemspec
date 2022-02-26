Gem::Specification.new do |s|
  s.name      = 'maildir2json'
  s.version   = '1.0.0'
  s.platform  = Gem::Platform::RUBY
  s.summary   = 'A simple tool to convert maildir format file to JSON format'
  s.description = 'A simple ruby script to convert maildir format file to JSON format'
  s.authors   = ['Amal Francis']
  s.email     = ['amalfra@gmail.com']
  s.homepage  = 'https://github.com/amalfra/maildir2json'
  s.license   = 'MIT'
  s.files     = Dir.glob("{lib,bin}/**/*")
  s.require_path = 'lib'
end
