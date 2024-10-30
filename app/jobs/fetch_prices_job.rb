class FetchPricesJob < ApplicationJob
  queue_as :default

  def perform(*args)  # اضافه کردن *args
    PriceFetcherService.new.fetch_prices
  rescue => e
    Rails.logger.error("Error in FetchPricesJob: #{e.message}")
  end
end