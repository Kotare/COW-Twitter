class User < ActiveRecord::Base
  has_many :tweets
  has_many :connections

  has_many :follower_connections, foreign_key: :followee_id, class_name: "Connection"
  has_many :followers, through: :follower_connections, source: :follower#:user_connections foreign_key :followee_id

  has_many :followee_connections, foreign_key: :follower_id, class_name: "Connection"
  has_many :followees, through: :followee_connections, source: :followee# through :user_connections foreign_key :follower_id

  validates :email,
    presence: true,
    format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Invalid Email Address"}

  validates :password,
    presence: true,
    format: {:with => /[([a-z]|[A-Z])0-9_-]{6,40}/, message: "Password must be at least 6 characters and include one number and one letter"}

end
