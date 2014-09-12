class ChangePrincipalInSubanalyzer < ActiveRecord::Migration
  def change
    rename_column :sub_analyzers, :total_pricipal, :total_principal
  end
end
