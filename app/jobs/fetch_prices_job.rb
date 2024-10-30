class FetchPricesJob < ApplicationJob
  queue_as :default

  def perform
    service = PriceFetcherService.new
    service.fetch_prices
  rescue => e
    Rails.logger.error("Error in FetchPricesJob: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
  end
end