class Users::Create < ActiveInteraction::Base
  hash :params do
    string :name, :patronymic, :email, :nationality, :country, :gender
    integer :age
    array :skills, default: []
    array :interests, default: []
  end

  def execute
    ActiveRecord::Base.transaction do
      errors.merge!(user.errors) unless user.valid?
      create_skills
      create_interests
    end
  end

  private

  def create_skills
    existing_skills = Skill.where(name: params[:skills], user_id: user.id)
    (params[:skills] - existing_skills).each do |skill_name|
      user.skills.build(name: skill_name)
    end
  end

  def create_interests
    existing_interests = Interest.where(name: params[:interests].split(","), user_id: user.id)
    (params[:interests] - existing_interests).each do |interest_name|
      user.interests.build(name: interest_name)
    end
  end

  def user = @user ||= User.create(params.except(:interests))
end
