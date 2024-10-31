class PriceFetcherService
  TOKENS = {
    usdc: "0x04068DA6C83AFCFA0e13ba15A6696662335D5B75",
    wftm: "0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83",
    wigo: "0xE992bEAb6659BFF447893641A378FbbF031C5bD6",
    lumos: "0xC74fE4c715510Ec2F8C61d70D397B32043F55Abe"
  }

  DEXES = {
    spookyswap: {
      name: "SpookySwap",
      factory: "0x152eE697f2E276fA89E96742e9bB9aB1F2E61bE3"
    },
    spiritswap: {
      name: "SpiritSwap",
      factory: "0xEF45d134b73241eDa7703fa787148D9C9F4950b0"
    }
  }

  def fetch_prices
    all_prices = []
    
    DEXES.each do |dex_key, dex_info|
      # FTM/USDC
      ftm_price = fetch_token_price(
        token_address: TOKENS[:wftm],
        usdc_address: TOKENS[:usdc],
        dex: dex_info,
        token_decimals: 18,
        usdc_decimals: 6
      )
      all_prices << ftm_price if ftm_price

      # WIGO/USDC
      wigo_price = fetch_token_price(
        token_address: TOKENS[:wigo],
        usdc_address: TOKENS[:usdc],
        dex: dex_info,
        token_decimals: 18,
        usdc_decimals: 6
      )
      all_prices << wigo_price if wigo_price

      # LUMOS/USDC
      lumos_price = fetch_token_price(
        token_address: TOKENS[:lumos],
        usdc_address: TOKENS[:usdc],
        dex: dex_info,
        token_decimals: 18,
        usdc_decimals: 6
      )
      all_prices << lumos_price if lumos_price
    end

    all_prices
  end

  private

  def fetch_token_price(token_address:, usdc_address:, dex:, token_decimals:, usdc_decimals:)
    pair_address = get_pair_address(dex[:factory], token_address, usdc_address)
    return nil unless pair_address

    reserves = get_pair_reserves(pair_address)
    return nil unless reserves && reserves.length == 2

    token_amount = reserves[1].to_f / (10**token_decimals)
    usdc_amount = reserves[0].to_f / (10**usdc_decimals)
    
    price = usdc_amount / token_amount

    {
      token: find_token_by_address(token_address),
      price_usdc: price.to_s,
      gas_fee: fetch_gas_price,
      rpc_url: current_rpc,
      dex: dex[:name]
    }
  end

  def find_token_by_address(address)
    case address.downcase
    when TOKENS[:wftm].downcase
      Token.find_by(symbol: 'FTM')
    when TOKENS[:wigo].downcase
      Token.find_by(symbol: 'WIGO')
    when TOKENS[:lumos].downcase
      Token.find_by(symbol: 'LUMOS')
    end
  end
end