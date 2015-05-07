class User < ActiveRecord::Base
  has_many :tweets
  has_many :user_connections
  has_many :followers ??
  has_many :following ??
end
