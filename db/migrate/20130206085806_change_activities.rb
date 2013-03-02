class ChangeActivities < ActiveRecord::Migration
  def up
    add_column :activities, :project_length, :integer
    add_column :activities, :project_area, :integer
    add_column :activities, :project_quantity, :integer
    add_column :activities, :blm_amount, :bigint
    add_column :activities, :self_fund_amount, :bigint
    add_column :activities, :male_proposal, :integer
    add_column :activities, :female_proposal, :integer
    add_column :activities, :male_beneficiary, :integer
    add_column :activities, :female_beneficiary, :integer
    add_column :activities, :poor_beneficiary, :integer
    add_column :activities, :subdistrict_id, :integer
    add_column :activities, :category_id, :integer
  end

  def down
    remove_column :activities, :project_length
    remove_column :activities, :project_area
    remove_column :activities, :project_quantity
    remove_column :activities, :blm_amount
    remove_column :activities, :self_fund_amount
    remove_column :activities, :male_proposal
    remove_column :activities, :female_proposal
    remove_column :activities, :male_beneficiary
    remove_column :activities, :female_beneficiary
    remove_column :activities, :poor_beneficiary
    remove_column :activities, :subdistrict_id
    remove_column :activities, :category_id
  end
end
