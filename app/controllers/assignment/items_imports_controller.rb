# frozen_string_literal: true

module Assignment
  class ItemsImportsController < BaseController
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
    end

    private

    def items_import_params
      params.require(:items_import).permit(:file)
    end
  end
end
