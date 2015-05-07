class User < ActiveRecord::Base
  has_many :tweets
  has_many :user_connections

  has_many :followers, through: :follower_connections, source: :follower#:user_connections foreign_key :followee_id
  has_many :follower_connections, foreign_key: :followee_id, class_name: "Connection"

  has_many :followees, through: :follower_connections, source: :follower# through :user_connections foreign_key :follower_id
  has_many :followee_connections, foreign_key: :follower_id, class_name: "Connection"
end
