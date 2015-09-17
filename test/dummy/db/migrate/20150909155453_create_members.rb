class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :company, index: true, foreign_key: true
      t.string :name
      t.integer :age
      t.date :birthday
      t.string :status

      t.timestamps null: false
    end
  end
end
