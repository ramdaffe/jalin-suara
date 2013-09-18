class ExcelFile < ActiveRecord::Base
  attr_accessible :document, :name
  has_attached_file :document
    :storage => :s3,
    :s3_credentials => {
      :bucket => 'qbl-paperclip',
      :access_key_id => 'AKIAJQVBIBHGZN5RQXQQ',
      :secret_access_key => '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'
    },
    :path => ":attachment/:id/:style.:extension"
end
