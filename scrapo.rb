require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"

require "pry"



url = "https://simply-home.herokuapp.com/house1.php"


    html = URI.open(url)
app = Nokogiri::HTML(html)
#db = SQLITE3::Database.new("maison.db")





# Vannes :      https://simply-home.herokuapp.com/index.php
# Auray :       https://simply-home-cda.herokuapp.com/pages/accueil.php
# Questembert : https://simply-home-group.herokuapp.com/Accueil.php


image = app.css(".singleArticleImage").img
titre = app.css(".surface").children.text
size = app.css(".size").children.text

p size
p image
p titre


binding pry