class CreateKlasses < ActiveRecord::Migration[8.0]
  def change
    create_table :klasses do |t|
      t.integer :number
      t.string :letter
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
