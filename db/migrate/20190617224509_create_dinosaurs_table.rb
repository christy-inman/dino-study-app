class CreateDinosaursTable < ActiveRecord::Migration[5.2]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :classification
      t.string :diet
      t.string :length
      t.string :height
      t.string :weight
      t.string :location
      t.string :time_period
      t.string :fact
    end
  end
end
