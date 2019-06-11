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

    def self.random_code(long_url)
        loop do
            short_url = SecureRandom::urlsafe_base64((long_url.length - 4) / 2)
            return short_url unless ShortenedUrl.exists?(short_url: short_url)
        end
    end

    def self.factory_user_and_longurl(user, long_url)
        short_url = ShortenedUrl.random_code(long_url) + '.com'
        ShortenedUrl.create!(
            user_id: user.id,
            short_url: short_url,
            long_url: long_url
        )
    end

end