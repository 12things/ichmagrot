# -*- encoding : utf-8 -*-
class Templates
  @@templates = [
    {
      :id => 'classic', :title => 'Klassisch', 
      :field_ids => [29,12,30,27,1,2,20,21,22,10,9,5,6,13,14,4,31,7,32,28,16]
    },
    {
      :id => 'girly', :title => 'Für Mädels', 
      :field_ids => [29,12,30,27,1,2,20,21,22,10,9,5,6,13,14,4,31,7,32,28,3,33,34,35,15]
    },
    {
      :id => 'school', :title => 'Für Schüler',
      :field_ids => [29,12,22,20,21,6,10,5,9,4,7,8,13,28,11,23,19,17,18,15]
    },
    {
      :id => 'men', :title => 'Für Männer', 
      :field_ids => [29,1,2,27,10,11,48,3,53,9,25,44,45,52,8,32,47,51,49,46,50,15]
    },
    {
      :id => 'geeks', :title => 'G33kz',
      :field_ids => [29,38,2,1,43,26,42,10,4,14,60,8,36,47,24,54,40,56,37,41,39,25,55,59]
    },
    {
      :id => 'sport', :title => 'Mein Verein',
      :field_ids => [29,12,30,27,1,2,20,21,22,6,13,10,9,65,66,63,64,67,61,62,16]
    },
    {
      :id => 'birthday', :title => 'Geburtstag',
      :field_ids => [29,12,30,27,1,2,20,21,22,10,9,5,6,13,14,4,31,7,32,28,68,69,70]
    },
    {
      :id => 'marriage', :title => 'Hochzeit', 
      :field_ids => [29,12,30,27,1,2,20,21,22,10,9,5,6,13,14,4,31,7,32,28,58,57]
    }
  ]

  def self.get_all
    @@templates
  end
  
  def self.get_by_index index
    @@templates[index.to_i]
  end

  def self.get_by_id id
    @@templates.find {|t| t[:id] == id }
  end
end
