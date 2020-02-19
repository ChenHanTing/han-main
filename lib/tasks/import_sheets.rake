# frozen_string_literal: true

namespace :import_sheets do
  desc 'A task used for import xlsx file to MCH database.'
  task mch: :environment do
    Mch.import_sheets(ENV['file'])
  end

  desc 'A task used for import xlsx file to Category database.'
  task category: :environment do
    Category.import_sheets(ENV['file'])
  end

  desc 'A task used for import xlsx file to CategoryMch database.'
  task category_mch: :environment do
    CategoryMch.import_sheets(ENV['file'])
  end
end
