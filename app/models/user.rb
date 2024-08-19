class User < ApplicationRecord
    def self.find_or_create_from_auth_hash(auth_hash)
        user = User.find_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
        if user
          user
        else
          User.create(
            name: auth_hash['info']['name'],
            email: auth_hash['info']['email'],
            uid: auth_hash['uid'],
            provider: auth_hash['provider']
          )
        end
    end
end
