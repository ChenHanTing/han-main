# frozen_string_literal: true

module Admin
  class QuestionTypesController < ApplicationController
    before_action :set_question_type, only: %i[show edit update]

    def index
      @question_types =
        if params[:search]
          QuestionType.ransack(search_params)
                      .result(distinct: true)
                      .order(updated_at: :DESC)
                      .page(params[:page])
                      .per(params[:per_page])
        else
          @search_params = {}
          QuestionType.all
                      .order(updated_at: :DESC)
                      .page(params[:page])
                      .per(params[:per_page])
        end
    end

    def new
      @question_type = QuestionType.new
    end

    def create
      @question_type = QuestionType.new(question_type_params
                                    .merge(status: question_type_params[:status]
                                    .to_i))

      if @question_type.save
        flash[:success] = '新增成功'

        redirect_to admin_question_types_path
      else
        flash.now[:error] = '新增失敗'

        render :new
      end
    end

    def edit; end

    def update
      if @question_type.update(question_type_params
                       .merge(status: question_type_params[:status]
                       .to_i))
        flash[:success] = '更新成功'

        redirect_to admin_question_types_path
      else
        flash.now[:error] = '更新失敗'

        render :edit
      end
    end

    private

    def set_question_type
      @question_type = ::QuestionType.find(params[:id])
    end

    def question_type_params
      params.require(:question_type).permit(:status, :name)
    end

    def search_params
      @search_params ||= params.require(:search).permit(:status_eq, :name_cont)
      @search_params
    end
  end
end
