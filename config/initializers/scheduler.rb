require 'rufus-scheduler'

unless defined?(Rails::Console) || Rails.env.test? || File.split($PROGRAM_NAME).last == 'rake'
  scheduler = Rufus::Scheduler.singleton

  scheduler.every '30s' do
    FetchPricesJob.perform_later
  end
end