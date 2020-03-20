# frozen_string_literal: true

module Assignment
  class ItemsImportsController < BaseController
    def new
      @items_import = ItemsImport.new
    end

    def create
      binding.pry
      # <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>
      # "GPKscLyw/+WHNbetdfrKCL8NHWx3siBHskdOwSyung061JfEYT76ijeagDUi6JjCfXKNhEPgmQ3PN/O5WKw/yw==",
      # "items_import"=>{"file"=>#<ActionDispatch::Http::UploadedFile:0x00007f984a5d6c88
      # @tempfile=#<Tempfile:/var/folders/sk/5k5tb2y91m3gv1jcky4f9rbw0000gn/T/RackMultipart20200320-78279-192p5fz.jpg>,
      # @original_filename="GBA黑.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data;
      # name=\"items_import[file]\"; filename=\"GBA\xE9\xBB\x91.jpg\"\r\nContent-Type: image/jpeg\r\n">},
      # "commit"=>"Import File", "locale"=>"zh-TW", "controller"=>"assignment/items_imports", "action"=>"create"}
      # permitted: false>

      # https://medium.com/@JasonCodes/ruby-on-rails-importing-from-excel-1504fd99a35e
      #
      # @items_import = ItemsImport.new(params[:items_import])
      #
      # if @items_import.save
      #   redirect_to items_path
      # else
      #   render :new
      # end
    end
  end
end
