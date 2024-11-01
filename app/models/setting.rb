class Setting < ApplicationRecord
    validates :key, presence: true, uniqueness: true
    validates :value, presence: true
  
    def self.get(key)
      Rails.cache.fetch("settings:#{key}", expires_in: 1.hour) do
        setting = find_by(key: key)
        setting&.value
      end
    end
  
    def self.set(key, value)
      setting = find_or_initialize_by(key: key)
      setting.value = value
      setting.save!
      Rails.cache.delete("settings:#{key}")
      value
    end
  
    def self.tokens
      get('tokens') || [
        { id: 1, symbol: "FTM", name: "Fantom" },
        { id: 2, symbol: "LUMOS", name: "Lumos" },
        { id: 3, symbol: "WIGO", name: "Wigo" }
      ]
    end
  
    def self.networks
      get('networks') || [
        { rpc_url: "https://rpc.ftm.tools", name: "FTM Tools" },
        { rpc_url: "https://rpcapi.fantom.network", name: "Fantom Network" },
        { rpc_url: "https://rpc.ankr.com/fantom", name: "Ankr" }
      ]
    end
  
    def self.update_tokens(tokens)
      validate_tokens!(tokens)
      set('tokens', tokens)
    end
  
    def self.update_networks(networks)
      validate_networks!(networks)
      set('networks', networks)
    end
  
    private
  
    def self.validate_tokens!(tokens)
      raise ArgumentError, "Tokens must be an array" unless tokens.is_a?(Array)
      tokens.each do |token|
        unless token.is_a?(Hash) && token['id'].present? && token['symbol'].present? && token['name'].present?
          raise ArgumentError, "Invalid token format: #{token}"
        end
      end
    end
  
    def self.validate_networks!(networks)
      raise ArgumentError, "Networks must be an array" unless networks.is_a?(Array)
      networks.each do |network|
        unless network.is_a?(Hash) && network['rpc_url'].present? && network['name'].present?
          raise ArgumentError, "Invalid network format: #{network}"
        end
      end
    end
  end