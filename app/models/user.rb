class User < ApplicationRecord
	has_secure_password
	has_many :microposts, dependent: :destroy
	has_many :active_relationships, class_name:  "Relationship",
             foreign_key: "follower_id",
             dependent:   :destroy

    has_many :passive_relationships, class_name:  "Relationship",
             foreign_key: "followed_id",
             dependent:   :destroy

    has_many :following, through: :active_relationships,  source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    validates_length_of       :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
	validates_confirmation_of :password, allow_nil: true, allow_blank: false

	validates :name, presence: true, length: {maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

	before_validation do
	  (self.email = email.to_s.downcase) && (self.username = username.to_s.downcase)
	end

	  # Make sure email and username are present and unique.
	  validates_presence_of     :email
	  validates_presence_of     :username
	  validates_uniqueness_of   :email
	  validates_uniqueness_of   :username
end
