# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  belongs_to :user
  has_many :pages, :order => "position"
  has_attached_file :background_image, :styles => { :thumb => "100x100#" }
  
  validates_presence_of :title, :message => "muss ausgefüllt werden"
  
  serialize :field_ids
  
  STEPS = 5
  
  def owner? user
    self.user == user
  end
  
  def has_page_for_user? user
    !self.pages.find_by_user_id(user.id).nil?
  end
  
  def page_for_user user
    self.pages.find_by_user_id(user.id)
  end
  
  def owners_page
    page_for_user self.user
  end
  
  def fields
    fields = Field.where("id in (?)", self.field_ids)
    fields = fields.order("FIELD(id, #{self.field_ids.join(',')})") unless self.field_ids.nil? || self.field_ids.empty?
    fields.all
  end
  
  def addable_fields
    if self.field_ids.nil? || self.field_ids.empty?
      Field.all
    else
      Field.where("id not in (?)", self.field_ids)
    end
  end
  
  def in_progress?
    self.progress < STEPS
  end
  
  def next_step
    if in_progress?
      self.progress += 1
      save
    end
  end
end
