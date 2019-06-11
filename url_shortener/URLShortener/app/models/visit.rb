class Visit < ApplicationRecord

    validates :user_id, presence: true
    validates :url_id, presence: true

end