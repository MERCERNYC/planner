class User < ActiveRecord::Base
  has_secure_password
  has_many :lists
  has_many :tasks, through: :lists
#validate the presence of username, password and email
  validates :username,:email, :password, presence: true
end
