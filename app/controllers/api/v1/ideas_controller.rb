# frozen_string_literal: true

module Api
  module V1
    class IdeasController < BaseController
      skip_before_action :verify_authenticity_token

      def index
        @ideas = Idea.order('created_at DESC')
        render json: @ideas
      end

      def create
        @idea = Idea.create(idea_params)
        render json: @idea
      end

      def update
        @idea = Idea.find(params[:id])
        @idea.update_attributes(idea_params)
        render json: @idea
      end

      def destroy
        @idea = Idea.find(params[:id])
        if @idea.destroy
          head :no_content, status: :ok
        else
          render json: @idea.errors, status: :unprocessable_entity
        end
      end

      private

      def idea_params
        params.require(:idea).permit(:title, :body)
      end

      # 驗證該 token 是否符合格式
      def token_format_valid?(authentication_token)
        base58_alphabet = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a - %w[0 O I l]
        (authentication_token.split('') - base58_alphabet).blank? && authentication_token.size == 24
      end
    end
  end
end
