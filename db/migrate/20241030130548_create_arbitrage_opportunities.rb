class CreateArbitrageOpportunities < ActiveRecord::Migration[7.0]
  def change
    create_table :arbitrage_opportunities do |t|
      t.decimal :buy_price
      t.decimal :sell_price
      t.decimal :profit
      t.references :token, null: false, foreign_key: true

      t.timestamps
    end
  end
end
