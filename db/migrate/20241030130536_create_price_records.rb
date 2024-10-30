class CreatePriceRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :price_records do |t|
      t.references :token, null: false, foreign_key: true
      t.decimal :price_usdc
      t.decimal :gas_fee
      t.string :rpc_url

      t.timestamps
    end
  end
end
