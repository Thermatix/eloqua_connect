Dir[File.dirname(__FILE__) + '/modules/*.rb'].each {|file| require file }
module Eloqua
  class RESTClient < Client
    include ExternalActivity
  end
end