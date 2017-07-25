require 'watir'
require 'nokogiri'

browser = Watir::Browser.new :chrome
#browser = Watir::Browser.new :chrome, :switches => %w[--load-extension=.../Chrome/User\ Data/Default/Extensions/geelfhphabnejjhdalkjhgipohgpdnoc/0.9.7_0]
browser.goto "http://www.0wikipedia.org/index.php?q=aHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvV2lraXBlZGlhOkZlYXR1cmVkX2FydGljbGVz"
sleep(2)
articleDoc = Nokogiri::HTML.parse(browser.html) #article page parse
ulCount = articleDoc.css('table tbody td')[3].css('ul').count #article baslık count random icin
ulRand = rand(ulCount)
puts  ". ul"
puts ulRand
puts "\n"
liCount = articleDoc.css('table tbody td')[3].css('ul')[ulRand].css('li').count #baslıgın icindeki articlelardan random secmek icin
puts "li sayisi"
puts   liCount
liRand = rand(liCount)
puts "\n"
puts liRand
puts ". li"
name = browser.table.tbody.tds[3].uls[ulRand].lis[liRand].a.text
puts "adı = " + name
sleep(2)
toClick = browser.link(title: "#{name}")
sleep(2)
toClick.fire_event('click')
sleep(2)
doc = Nokogiri::HTML.parse(browser.html)
pCount = doc.css('div#mw-content-text div.mw-parser-output p').count #paragraph count
i = 0
content =  ""
while ( i < pCount)
    content += doc.css("div#mw-content-text div.mw-parser-output p")[i].text
    i += 1
end
wordArray = Array.new
wordArray = content.scan(/\b[a-z]{5,}\b/)

wordRand = rand(wordArray.length)


puts wordArray[wordRand]
#return wordArray[wordRand]
sleep(50)