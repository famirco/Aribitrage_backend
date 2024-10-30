require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '30s' do
  FetchPricesJob.perform_later
end
