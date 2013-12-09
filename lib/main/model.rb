module EloquaConnect
  class Model < Base
    include ContactFields
    def initialize hash_to_pass=nil
      Object.const_get("EQC_config").models.each do |model|
        if self.class.name == model.modelName
          self.fields = model.fields.dup
          self.modelType = model.modelType
        else
          raise "no matching models"
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
      t = Object.const_get("EQC_config")
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
      results = Object.const_get("EQC_config").client.send("create_#{self.modelType.downcase}",sending)
      if results.is_a?(Array)
        r = results.first
       self.errors << "Eloqua Rest API Error, #{r["type"]}, property:#{r["property"]}, requirement: #{r["requirement"]["type"]}"
       return false
      else
        return true
      end
    end

    private
      def sending
        id = FIELDS[:emailAddress]
        email = ""
        f = self.fields.dup
        self.fields.each_with_index do |field,i|
          if field[:id] == id
            email = field[:value]
            f.delete_at(i)
          end
        end
        if email
          hash = {emailAddress: email, fieldValues: f}
        else
          hash = {fieldValues: f}
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