module EloquaConnect
  class ModelSetup < Base
    def initialize
      yield(self)
      temp = []
      self.fields.each do |field|
        temp << { id: field, value: "" }
      end
      self.fields = temp
    end
  end
end