class User < ActiveRecord::Base
  has_secure_password
  has_many :tasks
#validate the presence of username, password and email
  validates :username,:email,:password, presence: true
  validates :email, uniqueness: true
end
