class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.integer :cold
      t.integer :fever
      t.integer :flu
      t.integer :strepthroat

      t.timestamps null: false
    end
  end
end
