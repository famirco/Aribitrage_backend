require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

scheduler.every '1m' do
  DetectArbitrageJob.perform_later
end