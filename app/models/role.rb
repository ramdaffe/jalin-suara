class Role < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true

  def get_subdistrict_name
    subdistrict_name = ""

    if self.resource_type == "Subdistrict"
      subdistrict = Subdistrict.find(self.resource_id)
      if subdistrict != nil
        subdistrict_name = subdistrict.name
      end
    end

    return subdistrict_name
  end
end
