class PriceFetcherService
  RPC_URLS = [
    ENV['RPC_URL_1'],
    ENV['RPC_URL_2'],
    ENV['RPC_URL_3'],
    ENV['RPC_URL_4']
  ]

  TOKEN_ADDRESSES = {
    'FTM' => '0x4e15361fd6b4bb609fa63c81a2be19d873717870',
    'LUMOS' => '0x94fBE860aD699670A2293D194CF1376EF58C014a',
    'WIGO' => '0xE992bEAb6659BFF447893641A378FbbF031C5bD6',
    'USDC' => '0x04068DA6C83AFCFA0e13ba15A6696662335D5B75'
  }

  def initialize
    @web3_clients = RPC_URLS.map { |url| Web3::Eth::Rpc.new(url) }
  end

  def fetch_prices
    TOKEN_ADDRESSES.each do |token_name, contract_address|
      @web3_clients.each_with_index do |client, index|
        begin
          price = get_token_price(client, contract_address)
          gas_fee = get_gas_fee(client)
          
          PriceRecord.create!(
            token_name: token_name,
            price_usdc: price,
            gas_fee: gas_fee,
            rpc_url: RPC_URLS[index]
          )
        rescue => e
          Rails.logger.error("Error fetching price for #{token_name} from #{RPC_URLS[index]}: #{e.message}")
        end
      end
    end
  end

  private

  def get_token_price(client, token_address)
    # اینجا کد دریافت قیمت از اسمارت کانترکت را قرار دهید
    # این یک مثال ساده است
    contract = client.eth.contract(address: token_address, abi: token_abi)
    price = contract.methods.getPrice().call
    Web3::Utils.from_wei(price)
  end

  def get_gas_fee(client)
    gas_price = client.eth.gas_price
    Web3::Utils.from_wei(gas_price, 'gwei')
  end

  def token_abi
    # ABI اسمارت کانترکت را اینجا قرار دهید
    [
      {
        "constant": true,
        "inputs": [],
        "name": "getPrice",
        "outputs": [{"name": "", "type": "uint256"}],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      }
    ]
  end
end