module Error
  module Handler
    # 2019.12.22：因為檔案夾名取錯而卡很久

    def self.included(clazz)
      clazz.class_eval do
        rescue_from SysErr do |e|
          # to_text 還沒有寫完
          render (request.format.json? ? e.to_res_json : e.to_text)
        end
      end
    end

    private

    def respond(error, status, message)
      render json: {
        error: error,
        status: status,
        message: message,
      }
    end
  end
end
