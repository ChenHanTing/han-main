# frozen_string_literal: true

# == Schema Information
#
# Table name: member_login_histories
#
#  id           :bigint           not null, primary key
#  login_at     :datetime
#  login_member :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class MemberLoginHistory < ApplicationRecord
end
