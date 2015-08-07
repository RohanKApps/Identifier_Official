class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :oneplace
      t.string :twoplace
      t.string :threeplace

      t.timestamps null: false
    end
  end
end
