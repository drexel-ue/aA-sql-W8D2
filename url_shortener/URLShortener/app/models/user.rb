class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true
    validate :check_email

    def check_email
        if !email.nil?
            errors[:email] << 'needs an @ dawg' if !email.include?('@')
            errors[:email] << 'needs an . dawg' if !email.include?('.')
        end
    end

end