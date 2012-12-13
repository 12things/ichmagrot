# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :book
  belongs_to :user, :autosave => true
  accepts_nested_attributes_for :user
  
  has_many :values, :dependent => :destroy
  
  acts_as_list :scope => :book
  has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100#" }
  
  def owner? user
    self.user == user
  end
  
  def never_updated?
    self.created_at == self.updated_at && self.values.empty?
  end
  
  def updateable?
    never_updated? || self.updated_at >= 30.minutes.ago
  end
  
  def sorted_values
    self.values.where("field_id in (?)", self.book.field_ids).order("FIELD(field_id, #{self.book.field_ids.join(",")})").all
  end
  
  def update_values values
    values.each do |field_id, content|
      value = self.values.find_by_field_id(field_id)||Value.new(:field_id => field_id, :page_id => self.id)
      value.content = content
      value.save
    end
  end
end
