class ImplementerUnit < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :facilitator, :facilitator_phone, :call_center
  belongs_to :subdistrict

  def get_subdistrict_name
    name = ''
    if self.subdistrict != nil
      name = self.subdistrict.name
    end

    return name
  end
end
