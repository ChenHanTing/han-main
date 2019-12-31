module Error
  class SysErr < StandardError
    attr_reader :error, :message, :status

    class << self
      def [](init, status = 400)

        if init.kind_of?(Symbol)
          error = init
          message = I18n.t("error.#{init}")
        else
          error = :server_error
          message = init
          status = 500
        end

        new(error: error, message: message, status: status)
      end
    end

    def initialize(error: nil, message: 'Something went wrong !!!', status: 400)
      @error = error
      @message = message
      @status = status
    end

    def to_res_json
      {
        json: {
          error: error,
          message: message,
          status: status,
        },
        status: (status.presence || 200),
      }
    end
  end
end
