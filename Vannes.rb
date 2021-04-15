require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"
require "pry"


db = SQLITE3::Database.new("maison.db")


# VANNES

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
        nomDeVille[0] 
    end
    def cp
        nomDeVille[1]
    end
    def info
        "#{@g} #{taille} #{ville} #{cp} #{@energy} #{prix} #{annee_de_construction}" 
    end
    def taille
        @size.delete_suffix!(' m²')
        j = @size.split('')
        i = 0
        a = ""
        l = j.length
       loop do
           a += j[i] if j[i].ord >= 48 && j[i].ord <= 57
           a += "0" if j[i] == "à"
          break if i == l - 1
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
        g = @foundation_years 
        return "?" if g == "Inconnu" || g == "inconnu"
        g 
    end

    def presentation
        "prix de la maison : #{prix} €\nsurface de la maison : #{taille} m²\nprix au mètre carré : #{prix_au_metre_carre} €/m"
        #rix au mètre carré ; #{prix / taille} €/m"
    end

    def prix_au_metre_carre
        prix.to_i / taille.to_i
    end

    def energie 
        return "Non rensigné" if @energy == "N/A"
        @energy
    end
    
    db.execute("INSERT OR IGNORE INTO house VALUES (#{@g} #{prix})")



 
end


a = "https://simply-home.herokuapp.com/house"
php = ".php"
url = ""

i = 1  
  loop do
    
    url = a + i.to_s + php 
    html = URI.open(url)
    app = Nokogiri::HTML(html)
    

    g = i
    size = app.css(".size").children.text
    location = app.css(".location").children.text
    price = app.css(".price").children.text
    energy = app.css(".energy").children.text
    foundation_years = app.css(".foundation-years").children.text



    maison = Maison.new(g, size, location, price, energy, foundation_years)
    
    
   # p maison.info
     p maison.presentation
    # p maison.prix_au_metre_carre
    

    

    break if i == 15
    i = i + 1 
  end



  
binding pry