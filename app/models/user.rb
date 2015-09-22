class User < ActiveRecord::Base
  has_many :organization_memberships
  has_many :organizations, :through => :organization_memberships

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
