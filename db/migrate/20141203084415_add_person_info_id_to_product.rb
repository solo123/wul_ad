class AddPersonInfoIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :person_info_id, :integer, :default => 0
  end
end
