# frozen_string_literal: true

class ImportSheetsLegacy
  def initialize(obj, file, column)
    @column = column
    @file = file
    @obj = obj
  end

  # Import multiple sheets
  def import_sheets
    spreadsheet = self.class.open_spreadsheet(@file)
    spreadsheet.sheets.each do |sheet|
      import(sheet, @obj.class::SHEET_COLUMN, @obj.class::CODE_COLUMN)
    end
  end

  # Import a sheet
  def import(sheetname, sheet, code)
    spreadsheet = self.class.open_spreadsheet(@file)
    return if spreadsheet.sheet(sheetname).first_row.nil?

    header = spreadsheet.sheet(sheetname).row(1).map do |head|
      @obj.class::HEADER[head&.to_sym] || head
    end

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      @obj[sheet] = sheetname

      # you can write custom code here

      # This is written for Mch model
      # To deal with `c2, c3, c4`
      case @obj.class.to_s
      when 'Mch' then save_to_mch(@column[1...4].length, row, code)
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file)
    when '.csv' then Roo::Csv.new(file.path)
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file}"
    end
  end

  private

  # This is written for Mch model
  # Example:
  # Mch.importsheets('smsheets.xlsx')
  def save_to_mch(num, row, code)
    length = @column[1...4].length
    (0..length).each do |j|
      num = (length - j)

      if num == length
        @obj.attributes = row.to_hash.slice(*@obj.attributes.keys)
      else
        @obj = @obj.dup
      end

      @obj["c#{num + 2}"] = nil if num < length
      @obj[code] = row['MCH'].to_s
      (1..num).each { |n| @obj[code] += row["code#{n + 1}"].to_s }
      next if @obj[(@column[0]).to_s].nil? || @obj[code] == ''

      @obj.class.find_or_create_by!(@obj.attributes.slice(*@column))
    end
  end
end
