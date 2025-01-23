class UsersController < ApplicationController
  def create
    outcome = Users::Create.run(params: params.to_unsafe_h)
    if outcome.valid?
      render json: outcome.result
    else
      render json: {
        errors: outcome.errors.details.values.flatten
      }, status: 400
    end
  end
end
