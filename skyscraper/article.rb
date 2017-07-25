require 'watir'
require "nokogiri"
def getArticle()
    browser = Watir::Browser.new :chrome
    browser.goto "http://www.0wikipedia.org/index.php?q=aHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvV2lraXBlZGlhOkZlYXR1cmVkX2FydGljbGVz"
    sleep(2)
    articleDoc = Nokogiri::HTML.parse(browser.html) #article page parse
    ulCount = doc.css('table tbody td[3] ul').count #uls count for random
    i = rand(ulCount)
    browser.table.tbody.tds[3].uls[0].lis[0].span.a.click
    sleep(2)
    doc = Nokogiri::HTML.parse(browser.html)
    pCount = doc.css('div#mw-content-text div.mw-parser-output p').count #paragraph count
    i = 0
    content =  ""
    while ( i < pCount)
       content += doc.css('div#mw-content-text div.mw-parser-output p')[i].text
        i += 1
    end
end


#input class autocomplete