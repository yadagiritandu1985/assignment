class User < ApplicationRecord

  #encrypt password
  has_secure_password
  
  #associations
  has_many :appointments, dependent: :destroy

  #Validations
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email

end
