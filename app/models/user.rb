class User < ActiveRecord::Base
  has_many :tweets
  has_many :user_connections
  has_many :followers through :user_connections foreign_key :followee_id
  has_many :followees through :user_connections foreign_key :follower_id
end
