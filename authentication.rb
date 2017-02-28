require 'bcrypt'

class User < ActiveRecord::Base
  validates :full_name, :password, presence: true
  validates :email, uniqueness: true, presence: true

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(provided_email, entered_password)
    user = User.find_by(email: provided_email)
    return false if user.nil?
    user.password == entered_password
  end

end
