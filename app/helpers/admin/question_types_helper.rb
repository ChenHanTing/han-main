# frozen_string_literal: true

module Admin::QuestionTypesHelper
  def type_of_question_statuses
    QuestionType
      .statuses
      .map { |key, value| [value, t("question_types.status.#{key}")] }
  end
end
