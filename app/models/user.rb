class User < ApplicationRecord
    validates :username, :session_token,  presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    
    has_many :subs,
        class_name: :Sub,
        foreign_key: :moderator_id

    has_many :posts,
        foreign_key: :author_id
        # class_name: :Post
    
    attr_reader :password
    after_initialize :ensure_token
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        # self.reset_token!
        # self.save!
        self.password_digest
    end
    def valid_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end
    def reset_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
    def ensure_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end
end
