class ShortenedUrl < ApplicationRecord

    validates :user_id, presence: true
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true
    validate :check_urls

    def check_urls

        if !short_url.nil? && !long_url.nil?
            if short_url.length >= long_url.length
                errors[:short_url] << 'too damn long to be short'
            elsif !short_url.include?('.')
                errors[:short_url] << 'needs a . DAWG'
            elsif !long_url.include?('.')
                errors[:long_url] << 'needs a . DAWG'
            end
        end

    end

end