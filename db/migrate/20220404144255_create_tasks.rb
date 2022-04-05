class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.belongs_to :shift, null: false, foreign_key: true
      t.belongs_to :center, null: false, foreign_key: true
      t.string :status, default: "Pending"
      t.datetime :start

      t.timestamps
    end
  end
end
