class AddEndangeredWorker
  require 'csv'
  include Sidekiq::Worker
  sidekiq_options retry: false

  def puts(i)
    # code here
  end

  def perform(content)
    return if content.nil? || JSON.parse(content).length == 0

    JSON.parse(content).each { |c| Idea.create(title: "Excel 匯入", body: c) }
  end
end
