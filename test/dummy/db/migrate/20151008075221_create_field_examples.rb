class CreateFieldExamples < ActiveRecord::Migration
  def change
    create_table :field_examples do |t|
      t.references :member, index: true, foreign_key: true
      t.string :status
      t.boolean :checked
      t.string :subject
      t.text :body
      t.integer :age
      t.date :birthday
      t.datetime :birtydatetime
      t.time :birthtime

      t.timestamps null: false
    end
  end
end
