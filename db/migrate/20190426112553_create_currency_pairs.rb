class CreateCurrencyPairs < ActiveRecord::Migration[5.2]
  def change
    create_table :currency_pairs do |t|
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
