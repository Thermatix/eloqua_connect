require_relative 'modules/fields'
module EloquaConnect
  class Config < Base
    include ContactFields
    def intialize
      yield(self)
      self.client = Eloqua::RESTClient.new({
        site: self.company,
        username: self.username,
        password: self.password })
    end
  end
end