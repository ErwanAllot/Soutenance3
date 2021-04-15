require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"

require "pry"


a = "https://simply-home.herokuapp.com/house"
b = "https://simply-home-cda.herokuapp.com/pages/"
c = "https://simply-home-group.herokuapp.com/"
q = "questembert"
v = "maison_vannes_"
s = "sene"
php = ".php"
url = ""
i = 1

# https://simply-home.herokuapp.com/images/img-soutenance/maison_pierre.jpg



loop do
    url = a + i.to_s + php if i < 16
    url = b + (i-15).to_s + php if i > 15 && i < 31
    url = c + q + (i-30).to_s + php if i > 30 && i < 36
    url = c + v + (i-35).to_s + php if i > 35 && i < 41
    url = c + s + (i-40).to_s + php if i > 40

    html = URI.open(url)
app = Nokogiri::HTML(html)
#db = SQLITE3::Database.new("maison.db")






if i < 16
    g = i
size = app.css(".size").children.text
location = app.css(".location").children.text
price = app.css(".price").children.text
energy = app.css(".energy").children.text
foundation_years = app.css(".foundation-years").children.text
end


#____________________________________

if i > 15 && i < 31
    g = i
    gd = app.css("#single-ad-description").children.text



    stl = gd.split("\n")
    
    

    size = stl[2]
    location = stl[3]
    price = stl[4]
    energy = stl[5]
    foundation_years = stl[6]
    end


    #______________________________________

    if i > 30 
        g = i
        size = app.css(".surface").children.text
        location = app.css(".city").children.text
        price = app.css(".price").children.text
        energy = app.css(".energetic").children.text
        foundation_years = app.css(".year").children.text
        end





p g, size, location, price, energy, foundation_years, ""
    break if i == 45
    i = i + 1
end





binding pry