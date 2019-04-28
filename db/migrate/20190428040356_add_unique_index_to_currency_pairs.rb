class AddUniqueIndexToCurrencyPairs < ActiveRecord::Migration[5.2]
  def change
    add_index :currency_pairs, [:from, :to], unique: true
  end
end
