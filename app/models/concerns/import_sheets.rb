# frozen_string_literal: true

module ImportSheets
  def self.included(base)
    base.class_eval do
      def self.import_sheets(file)
        spreadsheet = open_spreadsheet(file)
        spreadsheet.sheets.each do |sheet|
          import(file, sheet, self::SHEET_COLUMN, self::CODE_COLUMN)
        end
      end

      def self.import(file, sheetname, sheet, code)
        spreadsheet = open_spreadsheet(file)
        header = spreadsheet.sheet(sheetname).row(1).map do |head|
          const_defined?('HEADER') ? self::HEADER[head&.to_sym] || head : head
        end

        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]

          obj = find_by_id(row['id']) || new
          obj.attributes = row.to_hash.slice(*new.attributes.keys)
          obj[sheet] = sheetname
          obj[code] = %(#{row['MCH']}#{row['cc1']}#{row['cc2']}#{row['cc3']}#{row['cc4']})
          obj.save! unless obj[code].eql? ''

          obj2 = obj.dup
          obj2.c4 = nil
          obj2[code] = %(#{row['MCH']}#{row['cc1']}#{row['cc2']}#{row['cc3']})
          unless obj2[code].eql? ''
            find_or_create_by!(obj2.attributes.slice('c1', 'c2', 'c3', 'c4', 'cs'))
          end

          obj3 = obj2.dup
          obj3.c3 = nil
          obj3[code] = %(#{row['MCH']}#{row['cc1']}#{row['cc2']})
          unless obj3[code].eql? ''
            find_or_create_by!(obj3.attributes.slice('c1', 'c2', 'c3', 'cs'))
          end

          obj4 = obj3.dup
          obj4.c2 = nil
          obj4[code] = %(#{row['MCH']}#{row['cc1']})
          unless obj4[code].eql? ''
            find_or_create_by!(obj4.attributes.slice('c1', 'c2', 'cs'))
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
    end
  end
end
