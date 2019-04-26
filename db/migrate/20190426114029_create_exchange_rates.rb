class CreateExchangeRates < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_rates do |t|
      t.references :currency_pair, foreign_key: true
      t.date :date
      t.float :rate

      t.timestamps
    end
  end
end
