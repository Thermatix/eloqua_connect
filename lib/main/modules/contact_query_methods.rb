require 'benchmark'
module EloquaConnect
  module ContactQueryMethods

    def find_by_email val
      raise "Can Only search by email on contact type models"if !model_is_contact?
      client = get_client
      results = client.find_contact_by_email(val,{depth: "complete"})
      format(results,true)
      return self
    end

    def find_by_id val, options={}
      raise "Can Only search by id on contact type models(for now)"if !model_is_contact?
      client = get_client
      results = client.get_contact(val,{depth: "complete"})
      format(results,false)
      return self
    end

    def find val
      find_by_id(val)
    end

    def self.[](val)
      find_by_id(val)
    end

    private
      def format results, by_email
        fields_values = get_results(results,by_email)
        if fields_values
          temp_fields = self.fields.dup.sort_by {|i| i[:id]}
          temp_fields.each do |a|
            if a[:id] < 100005
              case a[:id]
                when 100001
                  a[:value] = fields_values['emailAddress']
                when 100002
                  a[:value] = fields_values['firstName']
                when 100003
                  a[:value] = fields_values['lastName']
                when 100004
                  a[:value] = "not implimented yetfind"
              end
            else
              a[:value] = fields_values['fieldValues'].detect{|b| a[:id].to_s == b["id"].to_s }["value"]
            end
          end
          self.id = fields_values['fieldValues'].detect { |b| b['id'] == "100032"  }["value"].gsub(/^CPPPL0*/,"")
          self.fields = temp_fields
        else
          searching_by = by_email ? "email Address" : "ID"
          self.errors << "No contact exists with that #{searching_by}"
        end
      end

      def get_results results, by_email
        if by_email
          temp = results["elements"].first
        else
          temp =  results
        end
        return temp
      end

      def get_client
        EloquaConnect.configuration.client
      end

      def model_is_contact?
        self.modelType == "contact"
      end
  end
end