module EloquaConnect
  class Base
    attr_accessor :fields, :modelName, :modelType, :id
    attr_reader  :errors

    private

      attr_writer :errors
  end
end