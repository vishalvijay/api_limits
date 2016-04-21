class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, index: true, unique: true, null: false
      t.string :url
      t.text :description

      t.timestamps null: false
    end
  end
end
