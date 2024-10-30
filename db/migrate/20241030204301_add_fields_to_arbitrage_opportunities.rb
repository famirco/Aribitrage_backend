class AddFieldsToArbitrageOpportunities < ActiveRecord::Migration[7.0]
  def change
    # تغییر precision و scale فیلدهای موجود
    change_column :arbitrage_opportunities, :buy_price, :decimal, precision: 20, scale: 10
    change_column :arbitrage_opportunities, :sell_price, :decimal, precision: 20, scale: 10
    change_column :arbitrage_opportunities, :profit, :decimal, precision: 10, scale: 2
    
    # اضافه کردن فیلدهای جدید
    add_column :arbitrage_opportunities, :buy_rpc, :string
    add_column :arbitrage_opportunities, :sell_rpc, :string
    add_column :arbitrage_opportunities, :gas_fee, :decimal, precision: 20, scale: 10
    add_column :arbitrage_opportunities, :transaction_fee, :decimal, precision: 20, scale: 10
    add_column :arbitrage_opportunities, :status, :string, default: 'detected'
  end
end
