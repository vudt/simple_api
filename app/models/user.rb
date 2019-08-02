class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :authentication_token, uniqueness: true

  has_many :posts, dependent: :destroy

  def username
  	email
  end

  def self.search_by_string(str)
  	where("email LIKE ?", "%#{ str }%")
  end
end
