module Eloqua
  module ExternalActivity
    def get_external_activity(activity_id, options={})
      get("data/activity/#{activity_id}",options)
    end

    def add_external_activity(data)
      post("data/activity", data)
    end

  end
end