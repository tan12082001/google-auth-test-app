class User < ApplicationRecord
    def self.find_or_create_from_auth_hash(auth_hash)
        where(uid: auth_hash['uid'], provider: auth_hash['provider']).first_or_create do |user|
          user.name = auth_hash['info']['name']
          user.email = auth_hash['info']['email']
          user.uid = auth_hash['uid']
          user.provider = auth_hash['provider']
        end
    end
end
