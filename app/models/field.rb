# -*- encoding : utf-8 -*-
class Field < ActiveRecord::Base
  has_many :values
end
