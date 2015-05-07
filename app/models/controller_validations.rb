class User
  validates :email
  presence: true
  format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Invalid Email Address"}

  validates :password
  presence: true
  format: {:with => /^[([a-z]|[A-Z])0-9_-]{6,40}$/, message: "Password must be at least 6 characters and include one number and one letter"}
end
