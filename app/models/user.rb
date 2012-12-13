# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  has_many :books
  has_many :pages
  
  before_create :generate_key
  
  validates_uniqueness_of :key
  validates_presence_of :name
  
  def generate_key size=6
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    self.key = (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
  
  def has_valid_email?
    !self.email.nil? && !self.email.match(/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/).nil?
  end
  
  def current_book
    if !self.books.empty?
      return self.books.first
    elsif !self.pages.empty?
      return self.pages.first.book
    end
  end
end
