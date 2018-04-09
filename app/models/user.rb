class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable,
  devise :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :candidate, optional: true
  validates :full_name, :facebook_access_token, :email, presence: true

end
