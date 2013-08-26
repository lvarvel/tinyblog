class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: {minimum: 4}, if: :validate_password?
  validates :email, presence: true, uniqueness: true, format: /.@./

  def self.authenticate_with_email_and_password(email, password)
    user = find_by_email(email)
    user if user && user.authenticate(password)
  end

  private

  def validate_password?
    new_record? || password.present? || password_confirmation.present?
  end
end
