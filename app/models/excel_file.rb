class ExcelFile < ActiveRecord::Base
  attr_accessible :document, :name
  has_attached_file :document
end
