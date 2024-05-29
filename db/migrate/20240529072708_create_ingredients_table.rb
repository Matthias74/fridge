class CreateIngredientsTable < ActiveRecord::Migration[7.0]
  def up
    create_table :ingredients do |t|
      t.string :name
      t.text :quantity

      t.timestamps
    end
  end

  def down
    drop_table :ingredients
  end
end
