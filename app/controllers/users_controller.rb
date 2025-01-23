class UsersController < ApplicationController
  def create
    outcome = Users::Create.run(params: params.to_unsafe_h)
    if outcome.valid?
      redirect_to(outcome.result)
    else
      @user = outcome.result
      render(:new)
    end
  end
end
