class Users::Create < ActiveInteraction::Base
  hash :params do
    string :name, :skills, :patronymic, :email, :nationality, :country, :gender
    integer :age
    array :interests, default: []
  end

  validate :validate_user

  def execute
    ActiveRecord::Base.transaction do
      build_skills
      build_interests
      user.save!
    end

    user
  end

  private

  def user = @user ||= User.new(params.except(:interests, :skills))

  def build_skills = params[:skills].split(",").uniq.each { user.skills.build(name: _1) }

  def build_interests = params[:interests].uniq.each { user.interests.build(name: _1) }

  def validate_user
    errors.merge!(user.errors) unless user.valid?
  end
end
