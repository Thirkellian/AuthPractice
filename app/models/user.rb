class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.base64.tr("+/", "-_")
    end while User.exists?(column => self[column])
  end
end
