# frozen_string_literal: true

module Assignment
  class ItemsImportsController < BaseController
    skip_before_action :verify_authenticity_token

    def new
      @items_import = ItemsImport.new
    end

    # https://medium.com/@JasonCodes/ruby-on-rails-importing-from-excel-1504fd99a35e
    #
    # Ruby on Rails 4 - CSV import - no implicit conversion into string
    # https://stackoverflow.com/questions/30395750/ruby-on-rails-4-csv-import-no-implicit-conversion-into-string/30395981
    #
    def create
      @sheet_val = ImportSheets::Promotion.new(self.class, items_import_params[:file].path).sty_flow.to_json

      respond_to do |format|
        format.js
        format.json { render json: @sheet_val.to_json }
      end
    end

    def excel_template
      @template = [
        { content: "'2631146634002" },
        { content: "'2633001796009" },
        { content: "'2631142373004" }
      ]

      respond_to do |format|
        format.xlsx
      end
    end

    private

    def items_import_params
      params.require(:items_import).permit(:file)
    end
  end
end
