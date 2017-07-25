def getSongInfo(searchWord)
    require "watir"
    require "nokogiri"
    lyrics = ""
    artist = ""
    song_name = ""
    genius = "genius"
    browser = Watir::Browser.new :chrome
    browser.goto "genius.com"
    browser.text_field(class: "autocomplete").wait_until_present
    browser.text_field(class: "autocomplete").set"#{searchWord}"
    sleep(2)
    browser.send_keys :enter
    i = rand(10)
    browser.div(id: "main").div(class: "search_results_container").ul(class: "song_list").lis[0].wait_until_present
    browser.div(id: "main").div(class: "search_results_container").ul(class: "song_list").lis[0].a.click
    sleep(10)
    doc = Nokogiri::HTML.parse(browser.html)


    doc.css('br').each{ |br| br.replace "{" } #brleri { le degistiriyorum
    lyrics = doc.css('div.lyrics section p').text
    artist = doc.css('a.header_with_cover_art-primary_info-primary_artist').text
    song_name = doc.css('h1.header_with_cover_art-primary_info-title').text
    puts song_name 
    puts artist
    #return artist, song_name, lyrics
    #infoArray  #artist , song_name, lyrics donduruyo
end




getSongInfo("tribal")