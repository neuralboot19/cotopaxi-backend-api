class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
