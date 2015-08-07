class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :days

      t.timestamps null: false
    end
  end
end
