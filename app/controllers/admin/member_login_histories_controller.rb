# frozen_string_literal: true

module Admin
  class MemberLoginHistoriesController < BaseController
    def index
      @member_login_histories = MemberLoginHistory.all
                                                  .order(updated_at: :DESC)
                                                  .page(params[:page])
                                                  .per(params[:per_page])
    end
  end
end
