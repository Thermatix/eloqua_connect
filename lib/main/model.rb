require 'json'
module EloquaConnect
  class Model < Base
    include ContactFields
    include ContactQueryMethods


    def initialize hash_to_pass=nil

      EloquaConnect.configuration.models.each do |model|
        if self.class.name == model.modelName
          self.fields = model.fields.dup
          self.modelType = model.modelType
        else
          raise "no matching modelsetup"
        end
      end

      if hash_to_pass
        hash_to_pass.each do |key,value|
          self.send("#{key}=",value)
        end
      end
      self.errors = []
    end

    def method_missing(meth,*args,&block)
      m = meth.to_s.gsub("=","")
      t = EloquaConnect.configuration
      searching = t.extendFields[:"#{m}"] || nil
      searching = FIELDS[:"#{m}"] || nil
      if searching
        if meth =~ /.*=/
          get_field(searching, true, args.first)
        else
          get_field(searching)
        end
      else
        super
      end
    end

    def save
      results = EloquaConnect.configuration.client.send("create_#{self.modelType.downcase}",sending)
      if results.is_a?(Array)
        r = results.first
       self.errors << results
       return false
      else
        return true
      end
    end

    def update
      raise "No ID detected, can't save unless object has ID" if !self.id
      s = sending
      ap s.to_json
      results = EloquaConnect.configuration.client.send("update_#{self.modelType.downcase}",self.id,s)
      if results.is_a?(Array)
        r = results.first
        self.errors << results
        return false
      else
        return true
      end
    end

    private
      def sending
        case self.modelType
        when "external_activity"
          hash = self.fields
        else
          emailID = FIELDS[:emailAddress]
          email = ""
          f = self.fields.dup
          self.fields.each_with_index do |field,i|
            if field[:id] == emailID
              email = field[:value]
              f.delete_at(i)
            end
          end
          if email
            hash = {emailAddress: email, fieldValues: f}
          else
            hash = {fieldValues: f}
          end
        end
        return hash

      end

      def get_field searching, setting=false, value=""
        self.fields.each do |field|
           if field[:id] == searching
            if setting
              field[:value] = value
            else
              return field[:value]
            end
           end
        end
      end

  end

end