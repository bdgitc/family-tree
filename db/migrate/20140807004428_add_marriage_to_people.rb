class AddMarriageToPeople < ActiveRecord::Migration
  def change
    add_column :people, :marriage, :integer
  end
end
