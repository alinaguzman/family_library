module ExceptionHandler

  extend ActiveSupport::Concern

  included do
    # to be raised before some actions if no id where I set the instance var
    rescue_from ActiveRecord::RecordNotFound do |err|
      json_response( { message: err.message }, :not_found)
    end

    # to be raised from @model.create!
    rescue_from ActiveRecord::RecordInvalid do |err|
      json_response( { message: err.message }, :unprocessable_entity)
    end
  end

end