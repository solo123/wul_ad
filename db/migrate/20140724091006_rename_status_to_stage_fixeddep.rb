class RenameStatusToStageFixeddep < ActiveRecord::Migration
  def change
    rename_column :fixed_deposits, :status, :stage
  end
end
