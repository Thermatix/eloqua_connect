require_relative 'modules/fields'

module EloquaConnect
  class Model < Base
    include ContactFields

    def intialize hash_to_pass=nil
      EloquaConnect::Config.models.each do |model|
        if self.name == model.modelName
          self.fields = model.fields
        end
      end

      if hash_to_pass
        hash_to_pass.each do |key,value|
          self.send(key,value)
        end
      end
    end

    def method_missing(meth,*args,&block)
      searching = EloquaConnect::Config.extend_fields[:"meth"] if EloquaConnect::Config.extend_fields[:"meth"]
      searching = FIELDS[:"#{meth}"] if FIELDS[:"#{meth}"]
      self.fields.each do |field|
         if field[:id] == searching
          field[:value] = args.first
         end
      end
    end

    def save
      results = EloquaConnect::Config.client.create_contact({fieldvalues: self.fields})
      return false if results["currentStatus"] != "Awaiting action"
      true
    end
  end

end