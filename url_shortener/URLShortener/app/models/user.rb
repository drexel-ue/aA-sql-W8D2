# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true
    validate :check_email

    has_many :submitted_urls,
        class_name: :ShortenedUrl,
        primary_key: :id,
        foreign_key: :user_id



    def check_email
        if !email.nil?
            errors[:email] << 'needs an @ dawg' if !email.include?('@')
            errors[:email] << 'needs an . dawg' if !email.include?('.')
        end
    end

end
