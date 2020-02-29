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

  desc 'A task used for reset Mch/Category/CategoryMch database.'
  task category_reset: :environment do
    CategoryMch.delete_all
    Mch.delete_all
    Category.where.not(parent_id: nil).delete_all
  end

  desc 'A task used for import xlsx file to Mch/Category/CategoryMch database.'
  task category_bundler: :environment do
    file = ENV['file']
    Mch.import_sheets(file)
    Category.import_sheets(file)
    CategoryMch.import_sheets(file)
  end
end
