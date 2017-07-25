
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
    return artist, song_name, lyrics
    #infoArray  #artist , song_name, lyrics donduruyo
end



def pickLyrics(infoArray, lyrics)
      part = Array.new(140, "")
    rArray = Array.new(2, "")    
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
              count += 1
            end
            i += 1
        end
    else
        position = lyrics.index(string)
        i = 0
        count = 0
        while lyrics[position + i ] != string do
            i += 1 
        end
        while(count < 3  && i < 140) do
            part[i] = lyrics[position +i]
            if (lyrics[position +i] == string)
              count += 1
            end
            i += 1
        end
    end
    stringpart = part.join("")
    stringpart.gsub!("{","\n")
    puts stringpart
    rArray[0] = infoArray[0] + "\n" + infoArray[1]
    rArray[1] = stringpart
    
   
    return rArray #2 lik array donduruyo
end
def appendFile(filename, song)
    open('posted.txt', 'a') { |f|
        f.print "\n" + song
        puts "Recorded -> " + song
    }
end
def readFile(file)
    i = 0
    fileArray = Array.new
    File.open(file, "r") do |f|
        f.each_line do |line|
            fileArray[i] = line
            i += 1
        end
    end
    return fileArray
end
def checkSong(song)
    array = Array.new
    value = true
    i = 0
    array = readFile('posted.txt')
    while(i < array.length) do
        if (array[i] == song)
            puts "Error Already Posted"
            value = false
        end
        i += 1
    end
    if (value == true)
        puts "Available Song"
    end
    value
end
def pickRandomWord()
    require "watir"
    require "nokogiri"
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
    while ( i < pCount) #p lerdeki contenti topluyo
        content += doc.css("div#mw-content-text div.mw-parser-output p")[i].text
        i += 1
    end
    wordArray = Array.new
    wordArray = content.scan(/\b[a-z]{5,}\b/) #5 ve daha uzun kücük harfli kelimeleri alıyo

    wordRand = rand(wordArray.length)


    puts wordArray[wordRand]
    return wordArray[wordRand]
end
def program()
    searchWord = pickRandomWord()
    infoArray = Array.new(3, "") #0 = artist , 1 = song_name, 2 full lyrics
    publishLyricsArray = Array.new(2, "") #0 = artist + song name  1 = 2 satır lyrics
    i = 0
    while (i < 1)
        infoArray = getSongInfo(searchWord)
        puts "program song name = " + infoArray[1] 
        if(checkSong(infoArray[1]))#song name dosyada yoksa 2 satır lyrics secilcek paylasılmak icin
            publishLyricsArray = pickLyrics(infoArray, infoArray[2])
            appendFile("posted.txt", infoArray[1]) #song name posted listesine ekleniyo
            File.open("lyrics.txt", 'w') {|f| f.write(publishLyricsArray[1]) } #dosyaya yazma
            File.open("out.txt", 'w') {|f| f.write(publishLyricsArray[0]) }
        end

#        puts "Artist + Song Name " + publishLyricsArray[0]
#        puts "2 Part Lyrics " + publishLyricsArray[1]
        if (publishLyricsArray[0] != "" && publishLyricsArray[1] != "") #lyrics ya da artist ve song boş degilse 1 saat uyu sonra yeniden arama yap
            sleep(20)
        end
        i += 1
    end
   
end

program()

#dosyadan okuyup random arancak şarkıyı seçme kısmı kaldı


  