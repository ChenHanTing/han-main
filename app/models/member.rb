# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  properties :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Member < ApplicationRecord
  serialize :properties, Hash

  after_initialize do
    %w[twitter_handle github_username].each do |property|
      define_singleton_method property do
        properties[property]
      end
    end
  end
end

# class A
#   class << self
#     def class_name
#       to_s
#     end
#   end
# end
# A.define_singleton_method(:who_am_i) do
#   "I am: #{class_name}"
# end
# A.who_am_i   # ==> "I am: A"

# guy = "Bob"
# guy.define_singleton_method(:hello) { "#{self}: Hello there!" }
# guy.hello    #=>  "Bob: Hello there!"
