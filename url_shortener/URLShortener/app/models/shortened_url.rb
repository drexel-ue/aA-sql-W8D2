# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  short_url  :string           not null
#  long_url   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord

    validates :user_id, presence: true
    validates :short_url, presence: true, uniqueness: true
    validates :long_url, presence: true
    validate :check_urls

    belongs_to :submitter,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id



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
