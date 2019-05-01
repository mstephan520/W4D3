# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

    validates :user_name, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, allow_nil: true

    after_initialize :ensure_session_token

    attr_reader :password

    has_many :cats,
        class_name: :Cat,
        foreign_key: :user_id

    has_many :cat_rental_requests,
        class_name: :CatRentalRequest,
        foreign_key: :user_id

    has_many :rented_cats,
        through: :cat_rental_requests,
        source: :cat

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        user && user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        bcrypt_password = BCrypt::Password.new(self.password_digest)
        bcrypt_password.is_password?(password)
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        self.session_token
    end
end
