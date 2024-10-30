class DetectArbitrageJob < ApplicationJob
    queue_as :default
  
    def perform
      ArbitrageDetectorService.new(1.0).detect_opportunities
    end
  end