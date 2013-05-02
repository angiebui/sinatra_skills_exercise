class CreateProfs < ActiveRecord::Migration
  def change
    create_table :proficiencies do |t|
      t.references :user
      t.references :skill
      t.integer :years, :null => false
      t.boolean :formal, :null => false
      t.timestamps
    end
  end
end
