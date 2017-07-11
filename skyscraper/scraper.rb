require "watir"
require "nokogiri"
lyrics = ""
artist = ""
song_name = ""
genius = "genius"

   

browser = Watir::Browser.new :chrome
#browser.minimize
browser.goto "http://www.google.com/"
browser.text_field(title: "Ara").set"pink floyd hey you #{genius}"
browser.button(type: "submit").click
browser.h3s(class: 'r')[0].click 
doc = Nokogiri::HTML.parse(browser.html)

#browser.screenshot.save 'screenshots\search-results.png'
doc.css('br').each{ |br| br.replace "{" }
lyrics = doc.css('div.lyrics section p').text
artist = doc.css('a.header_with_cover_art-primary_info-primary_artist').text
song_name = doc.css('h1.header_with_cover_art-primary_info-title').text
puts song_name 




part = Array.new(140, "")

chorus = "Chorus"
verse = "Verse"
string = "{"

if !lyrics.index(chorus).nil?
    position = lyrics.index(chorus)
    i = 0
    count = 0
    while lyrics[position + i ] != string do
        i += 1 
    end
    while(count < 3  && i < 140) do
        part[i] = lyrics[position +i]
        if (lyrics[position +i] == string)
          count+= 1
        end
        i += 1
    end
elsif !lyrics.index(verse).nil?
    position = lyrics.index(verse)
    i = 0
    count = 0
    while lyrics[position + i ] != string do
        i += 1 
    end
    while(count < 3  && i < 140) do
        part[i] = lyrics[position +i]
        if (lyrics[position +i] == string)
          count+= 1
        end
        i += 1
    end
end


  def  artistModifier
          
    
  end



stringpart = part.join("")
stringpart.gsub!('{','\n')
puts stringpart


  