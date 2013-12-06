Dir[File.dirname(__FILE__) + '/main/modules/*.rb'].each {|file| require file }
require 'main/base'
require 'main/config'
require 'main/modelsetup'
require 'main/model'
require 'awesome_print'
