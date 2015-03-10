class CreateQuacks < ActiveRecord::Migration
  def change
    create_table :quacks do |t|
      t.string :name
      t.string :title

      t.timestamps
    end
  end
end
