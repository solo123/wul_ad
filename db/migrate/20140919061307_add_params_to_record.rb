class AddParamsToRecord < ActiveRecord::Migration
  def change
    add_column :account_records, :resource_name, :string
    add_column :account_records, :resource_id, :integer
  end
end
