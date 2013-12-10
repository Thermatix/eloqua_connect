require 'rubygems'
require 'rake'
require 'echoe'


Echoe.new('eloqua_connect','0.0') do |p|
  p.summary = 'push data to eloqua with model like behavior'
  p.description = ''
  p.url = 'https://github.com/Thermatix/eloqua_connect'
  p.author = 'Martin Becker'
  p.email = 'mbeckerwork@gmail.com'
  p.ignore_pattern = []
  p.runtime_dependencies =['eloqua_api ~>0.0.9']
  p.development_dependencies =[]
end


Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|ext| load ext}