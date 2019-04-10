class Sub < ApplicationRecord
    validates :title, :description, :moderator_id, presence: true

    belongs_to :moderator,
        class_name: :User,
        foreign_key: :moderator_id

    has_many :posts
    
end
