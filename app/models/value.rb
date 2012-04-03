class Value < ActiveRecord::Base
  belongs_to :page
  belongs_to :field
end
