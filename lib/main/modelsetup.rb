module EloquaConnect
  class ModelSetup < Base
    def initialize
      yield(self)
      temp = []
      case self.modelType
        when "external_activity"
          temp = {
              type: "",
              id: "", depth: "",
              name: "",
              activityDate: "",
              activityType: "",
              assetName: "",
              assetType: "",
              contactId: "",
              campaignId: ""
            }
        else
          self.fields.each do |field|
            temp << { id: field, value: "" }
          end
      end
      self.fields = temp
      self.modelName.freeze
    end
  end
end