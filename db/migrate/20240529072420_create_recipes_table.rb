class CreateRecipesTable < ActiveRecord::Migration[7.0]
  def up
    create_table :recipes do |t|
      t.integer :rate
      t.text :author_tip
      t.string :budget
      t.string :prep_time
      t.string :name
      t.string :difficulty
      t.integer :people_quantity
      t.string :cook_time
      t.string :total_time
      t.text :nb_comments

      t.timestamps
    end
  end

  def down
    drop_table :recipes
  end
end
