module EloquaConnect
  class Config < Base
    include ContactFields
    def initialize
      yield(self)
      self.extendFields ||= {}
      self.client = Eloqua::RESTClient.new({
        site: self.company,
        username: self.username,
        password: self.password })
    end
  end
end