# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)



fields = [

# 1-5
  "Meine E-Mail - Adresse", 
  "Meine Telefon/Handy-Nummer", 
  "Mein schlimmster Fehler", 
  "Mein Lieblingsfilm", 
  "Mein Lieblingstier",					

# 6-10
  "Mein Lieblingsessen", 
  "Mein Lieblingslied", 
  "Mein Lieblings-Superheld", 
  "Mein Lieblingssport", 
  "Meine Hobbys",

# 11-15				
	"Mein Traumberuf",
	"Mein Geburtstag", 
	"Meine Lieblingsfarbe", 
	"Meine Lieblingsserie", 
	"Mein größter Wunsch",
	
# 16-20				
	"Was ich dir noch wünsche", 
	"Mein größtes Abenteuer", 
	"Unsere besten Streiche", 
	"Meine Lieblingsfächer", 
	"Meine Augenfarbe",
	
# 21-25		
	"Meine Haarfarbe", 
	"Meine Größe", 
	"Mein Lieblingslehrer", 
	"Mein Lieblingsspiel", 
	"Meine Lieblings-Webseite",
	
# 26-30								
  "Meine Webseite", 
  "Meine Adresse", 
  "Mein Lieblingsbuch", 
  "Mein Spitzname", 
  "Mein Sternzeichen",

# 31-35										
	"Mein Lieblingsschauspieler/in", 
	"Meine Lieblingsband", 
	"Hier kaufe ich am liebsten ein", 
	"Mein Lieblingsmarke", 
	"Mein Lieblingsduft",

# 36-40
	"Mein erster Rechner", 
	"Meine erste Konsole", 
	"Mein erster Nickname", 
	"Mein Lieblings-Social-Network", 
	"Mein Lieblings-Game-Character",

# 41-45
	"Anzahl meiner Follower", 
	"Meine Instant-Messaging-Adresse", 
	"Mein Blog", 
	"Mein Lieblingsauto", 
	"Mein Auto",

# 46-50
  "Mein Lieblingsbier", 
  "Die Größe meines Fernsehers", 
  "Mein berufliches Vorbild", 
  "Ich bin Sitzpinkler", 
  "Mein Lieblings-Cocktail",

# 51-55
	"Anzahl meiner Freundinnen", 
	"Mein Lieblingswerkzeug", 
	"Ich Grille so oft im Jahr", 
	"Mein Lieblings-Game-Genre", 
	"Meine Lieblings-Programmiersprache",
	
# 56-60
	"Meine Konsolen", 
	"Das wünsche ich dem Brautpaar", 
	"Was mich mit dem Brautpaar verbindet", 
	"Mein Lieblings-Codec",
	"Meine Lieblings-Actionfigur",

# 61-65
  "Meine Spielernummer",
  "Meine Spielerposition",
  "Meine Sportart",
  "Ich spiele im Verein",
  "Mein Lieblingssportler",
  
# 66-70
  "Mein Lieblingsverein",
  "Mein Trainer heißt",
  "Mein Lieblingskuchen",
  "Mein Geschenk",
  "Mein Geburtstagsgruß"
]

fields.each do |name|
  Field.create(:name => name)
end

puts "Created #{fields.size} initial Fields"
