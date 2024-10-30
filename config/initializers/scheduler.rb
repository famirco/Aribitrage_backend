require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '30s' do
  Rails.logger.info "Starting scheduled price fetch..."
  FetchPricesJob.perform_later
end