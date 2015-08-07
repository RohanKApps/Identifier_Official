class CreateSymptomTowns < ActiveRecord::Migration
  def change
    create_table :symptom_towns do |t|
      t.integer :coughing
      t.integer :sneezing
      t.integer :congestion
      t.integer :warm_temp
      t.integer :sweat_excess
      t.integer :tooth_pain
      t.integer :back_pain
      t.integer :chest_pain
      t.integer :body_chills

      t.timestamps null: false
    end
  end
end
