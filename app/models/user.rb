class User < ApplicationRecord
  has_many :interests
  has_many :skills

  validates :age, comparison: { greater_than: 1, less_than: 91 }
  validates :gender, inclusion: { in: %w[male female] }
  validates :email, uniqueness: true

  def full_name = "#{surname} #{name} #{patronymic}"
end
