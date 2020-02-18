# frozen_string_literal: true

module Devise
  module Encryptable
    module Encryptors
      class Sha1 < Base
        # 我有一个庞大的用户数据库（~200,000），我正在从ASP.NET应用程序转移到Ruby on Rails应用程序。
        # 我真的不想要求每个用户重置密码，所以我试图在Ruby中重新实现C＃密码散列函数。
        # https://stackoom.com/question/2DzG/%E5%9C%A8Ruby%E4%B8%AD%E9%87%8D%E6%96%B0%E5%AE%9E%E7%8E%B0ASP-NET%E6%88%90%E5%91%98%E8%B5%84%E6%A0%BC%E5%92%8C%E7%94%A8%E6%88%B7%E5%AF%86%E7%A0%81%E5%93%88%E5%B8%8C

        # require 'base64'
        # require 'digest'
        # require 'jcode'

        # def encode_password(password, salt)
        #   bytes = ''
        #   password.each_char { |c| bytes += c + "\x00" }
        #   salty = Base64.decode64(salt)
        #   concat = salty + bytes
        #   sha1 = Digest::SHA1.digest(concat)
        #   encoded = Base64.encode64(sha1).strip
        #   puts encoded
        # end

        def self.digest(password, _stretches, salt, _pepper)
          bytes = ''
          password.each_char { |c| bytes << c + "\x00" }
          sha1_digest = Digest::SHA1.digest(Base64.decode64(salt) + bytes)

          Base64.strict_encode64(sha1_digest)
        end

        def self.salt(_stretches)
          Base64.strict_encode64(Devise.friendly_token[0, 20])
        end
      end
    end
  end
end
