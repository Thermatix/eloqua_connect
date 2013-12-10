module EloquaConnect
  module ContactQueryMethods

    def find_by_email val
      client = Object.const_get("EQC_config").client
      results = client.find_contact_by_email(val,{depth: "complete"})
      format(results)
      return self
    end

    def find_by_id val, options={}
      client = Object.const_get("EQC_config").client)
      results = client.get_contact(val,{depth: "complete"})
      format(results)
      return self
    end

    def find val
      find_by_id(val)
    end

    def self.[](val)
      find_by_id(val)
    end

    private
      def format results
        fields_values = results["elements"].first["fieldValues"]
        self.fields.each do |field|
          fields_values.each do |fv|
            if fv["id"] == field[:id]
              field[:value] = fv["value"]
            end
          end
        end
      end
  end
end