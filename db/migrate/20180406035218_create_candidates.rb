class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.string :full_name, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
