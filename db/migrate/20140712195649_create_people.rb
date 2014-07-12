class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :parent_mother_id
      t.integer :parent_father_id
      t.text :description
      t.date :dob
      t.string :pob

      t.timestamps
    end
  end
end
