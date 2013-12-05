module EloquaConnect
  class Base
    attr_accessor   :fields, :modelName
    def self.extend_fields val
      define_method "extend_fields" do
        val
      end
    end
    def self.company val
      define_method "company" do
        val
      end
    end

    def self.username val
      define_method "username" do
        val
      end
    end

    def self.password val
      define_method "password" do
        val
      end
    end

    def self.models val
      define_method "models" do
        val
      end
    end

    def self.client val
      define_method "client" do
        val
      end
    end

  end
end