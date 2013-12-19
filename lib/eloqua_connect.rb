Dir[File.dirname(__FILE__) + '/main/modules/*.rb'].each {|file| require file }
require 'main/base'
require 'main/modelsetup'
require 'main/model'
require 'main/monke_patch/rest_client'

module EloquaConnect
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.configuration.post_setup
  end

  class Configuration
    attr_accessor :company, :username, :password, :extendFields, :client, :models
    def initialize
      self.extendFields ||= {}
    end

    def post_setup
      self.client = Eloqua::RESTClient.new({
        site: self.company,
        username: self.username,
        password: self.password })
    end
  end
end

