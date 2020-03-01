# frozen_string_literal: true

# == Schema Information
#
# Table name: question_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class QuestionType < ApplicationRecord
  enum status: { active: 1, disable: 0 }

  validates :name, presence: true
end
