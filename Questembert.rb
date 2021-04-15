require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"

require "pry"


# QUESTEMBERT

db = SQLITE3::Database.new("maison2.db")


class Maison
    def initialize (g, size, location, price, energy, foundation_years)
        @g = g
        @size = size
        @location = location
        @price = price
        @energy = energy
        @foundation_years = foundation_years
    end

    def nomDeVille
        @location.split(' ')
    end
    def ville
        nomDeVille[2] 
    end
    def cp
        nomDeVille[3]
    end
    def info
        "#{@g} #{taille} #{ville} #{cp} #{energie} #{prix} #{annee_de_construction}" 
    end
    def taille
        
        j = @size.split('')
        i = 0
        a = ""
        l = j.length
       loop do
           a += j[i] if j[i].ord >= 48 && j[i].ord <= 57
           a += "0" if j[i] == "à"
          break if i == l - 2
        i = i + 1
        end
       return a
        
    end
    def g
        @g
    end

    def prix
        j = @price.split('')
        i = 0
        a = ""
        l = j.length
        loop do
            a += j[i] if j[i].ord >= 48 && j[i].ord <= 57
           break if i == l - 1
         i = i + 1
         end
        return a    
    end


    def annee_de_construction
        j = @foundation_years .split('')
        i = 0
        a = ""
        l = j.length
        loop do
            a += j[i] if j[i].ord >= 48 && j[i].ord <= 57
           break if i == l - 1
         i = i + 1
         end
        return "Non renseigné" if a == nil
        a  
    end

    def presentation
        "prix de la maison : #{prix} €\nsurface de la maison : #{taille} m²\nprix au mètre carré : #{prix_au_metre_carre} €/m"
        #rix au mètre carré ; #{prix / taille} €/m"
    end

    def prix_au_metre_carre
        prix.to_i / taille.to_i
    end

    def energie 
        e = @energy.split(" ")
        e[3]
    end

end

c = "https://simply-home-group.herokuapp.com/"
q = "questembert"
v = "maison_vannes_"
s = "sene"
php = ".php"
url = ""


i = 1
loop do


    url = c + q + i.to_s + php if i <= 5
    url = c + v + (i-5).to_s + php if i > 5 && i <= 10
    url = c + s + (i-10).to_s + php if i > 10
    html = URI.open(url)
app = Nokogiri::HTML(html)


    g = i
    size = app.css(".surface").children.text
    location = app.css(".city").children.text
    price = app.css(".price").children.text
    energy = app.css(".energetic").children.text
    foundation_years = app.css(".year").children.text
 
maison = Maison.new(g, size, location, price, energy, foundation_years)
   p maison.info
  # p maison.presentation
 # p maison.prix_au_metre_carre
# p maison.energie

    break if i == 15
    i = i + 1
end

binding pry