require "nokogiri"
require "open-uri"
require "pry"
require "sqlite3"
require "pry"

# VANNES
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
        a = @foundation_years 
        return "?" if a == "Inconnu" || a == "inconnu"
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
        return "Non renseigné" if @energy == "N/A"
        @energy
    end
    
   
    



 
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



    maison = Maison.new(g, size, location, price, energy, foundation_years, url)


#    "#{@g} #{taille} #{ville} #{cp} #{@energy} #{prix} #{prix_au_metre_carre} #{annee_de_construction} #{@url}" 
   # db.execute("INSERT OR IGNORE INTO maison VALUES (:id, :taille, :ville, :cp, :énergie, :année de construction, :url, :prix au mètre carré, :price)",) {id: @g, taille: maison.taille, ville: maison.ville, cp : maison.cp, énergie: @energy, année de construction: maison.annee_de_construction,  url: maison.url, prix au mètre carré: maison.prix_au_metre_carre, price: maison.prix}
   db.execute ("INSERT OR IGNORE INTO bibi VALUES (:id, :taille, :ville, :cp, :energie, :prix, :an, :url, :ratio) "), {id: maison.g, taille: maison.taille, ville: maison.ville, cp:maison.cp, energie: maison.energie, prix: maison.prix, an: maison.annee_de_construction, url:maison.url, ratio:maison.prix_au_metre_carre  }




     #db.execute("INSERT OR IGNORE INTO woman VALUES (:id, :taille, :ville, :cp, :energie, :price, :anneeDeConstruction, :url, :prixCarre )"), {id: @g, taille: maison.taille, ville: maison.ville, cp : maison.cp, energie: @energy, prix: maison.prix, anneeDeConstruction: maison.annee_de_construction, url: maison.url, prixCarre: maison.prix_au_metre_carre}
   # p maison.info
    # p maison.presentation
    # p maison.prix_au_metre_carre
 

    

    break if i == 15
    i = i + 1 
  end



  
binding pry