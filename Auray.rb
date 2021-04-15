require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"

require "pry"


# AURAY
db = SQLite3::Database.open "maison.db"


class Maison
    def initialize (g, size, location, price, energy, foundation_years, url)
        @g = g
        @size = size
        @location = location
        @price = price
        @energy = energy
        @foundation_years = foundation_years
        @url = url
    end

    def g
        @g
    end

    def url
        @url
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
        "#{@g} #{taille} #{ville} #{cp} #{@energy} #{prix} #{prix_au_metre_carre} #{annee_de_construction} #{@url} #{prix_au_metre_carre}" 
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
       return a.to_i 
        
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
        return a.to_i     
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
        a.to_i   
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
        return "Non renseigné" if e[0] == "N/A" || e[0] == "Non"
        e[0]
    end




 
end

b = "https://simply-home-cda.herokuapp.com/pages/"

php = ".php"
url = ""
i = 1


i = 1
loop do


    url = b + i.to_s + php 
    html = URI.open(url)
app = Nokogiri::HTML(html)
#db = SQLITE3::Database.new("maison.db")








    g = i
    gd = app.css("#single-ad-description").children.text



    stl = gd.split("\n")
    
    

    size = stl[2]
    location = stl[3]
    price = stl[4]
    energy = stl[5]
    foundation_years = stl[6]
 


    


    maison = Maison.new(g, size, location, price, energy, foundation_years, url)
  # p maison.info
 # p maison.presentation
 # p maison.prix_au_metre_carre
# p maison.energie
db.execute ("INSERT OR IGNORE INTO bibi VALUES (:id, :taille, :ville, :cp, :energie, :prix, :an, :url, :ratio) "), {id: maison.g, taille: maison.taille, ville: maison.ville, cp:maison.cp, energie: maison.energie, prix: maison.prix, an: maison.annee_de_construction, url:maison.url, ratio:maison.prix_au_metre_carre  }


    break if i == 15
    i = i + 1
end





binding pry