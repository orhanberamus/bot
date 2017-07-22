
def getSongInfo()
    require "watir"
    require "nokogiri"
    lyrics = ""
    artist = ""
    song_name = ""
    genius = "genius"
    infoArray = Array.new(3, "")

    browser = Watir::Browser.new :chrome
    #browser.minimize
    browser.goto "http://www.google.com/"
    browser.text_field(title: "Ara").set"pink floyd hey you #{genius}"
    browser.button(type: "submit").click
    browser.h3s(class: 'r')[0].click 
    doc = Nokogiri::HTML.parse(browser.html)


    doc.css('br').each{ |br| br.replace "{" } #brleri { le degistiriyorum
    lyrics = doc.css('div.lyrics section p').text
    artist = doc.css('a.header_with_cover_art-primary_info-primary_artist').text
    song_name = doc.css('h1.header_with_cover_art-primary_info-title').text
    #puts song_name 
    #puts artist
    infoArray[0] = artist
    infoArray[1] = song_name
    infoArray[2] = lyrics
    return infoArray  #artist , song_name, lyrics donduruyo
end



def pickLyrics(infoArray)
    chorus = "Chorus"
    verse = "Verse"
    string = "{"
    rArray = Array.new(2,"")
    lyrics_part = Array.new(140, "")
    if !infoArray[2].index(chorus).nil?  #chorus varsa chorustan 2 satır al
    position = infoArray[2].index(chorus)
    i = 0
    count = 0
    while infoArray[2][position + i ] != string do
        i += 1 
    end
    while(count < 3  && i < 140) do #chorus ya da verseden sonra {  geliyo o {den 2 sonrasına kadar alıyoru m 2 line ediyo
        lyrics_part[i] = infoArray[2][position +i]
        if (infoArray[2][position +i] == string)
          count+= 1
        end
        i += 1
    end
    elsif !infoArray[2].index(verse).nil? #chorus yoksa verseden 2 satır al
        position = infoArray[2].index(verse)
        i = 0
        count = 0
        while infoArray[2][position + i ] != string do
            i += 1 
        end
        while(count < 3  && i < 140) do
            lyrics_part[i] = infoArray[2][position +i]
            if (infoArray[2][position +i] == string)
              count+= 1
            end
            i += 1
        end
    else  #2si de yoksa ilk { den sonra 2 satır al
        position = infoArray[2].index(string)
        i = 0
        count = 0
        while infoArray[2][position + i ] != string do
            i += 1 
        end
        while(count < 3  && i < 140) do
            lyrics_part[i] = infoArray[2][position +i]
            if (infoArray[2][position +i] == string)
              count+= 1
            end
            i += 1
        end
    end
    stringpart = lyrics_part.join("") #lyricin partını birleştirip string yapıorm
    stringpart.gsub!("{","\n") # { leri linebreakle degistiriorum
    #puts stringpart
    rArray[1] = stringpart
    rArray[0] = infoArray[0] + "\n" + infoArray[1]
   
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
def program()
    infoArray = Array.new(3, "") #0 = artist , 1 = song_name, 2 full lyrics
    publishLyricsArray = Array.new(2, "") #0 = artist + song name  1 = 2 satır lyrics
    i = 0
    while (i < 2)
        infoArray = getSongInfo()
        puts "program song name = " + infoArray[1] 
        if(checkSong(infoArray[1]))#song name dosyada yoksa 2 satır lyrics secilcek paylasılmak icin
            publishLyricsArray = pickLyrics(infoArray)
            appendFile("posted.txt", infoArray[1])
            File.open("lyrics.txt", 'w') {|f| f.write(publishLyricsArray[1]) } #dosyaya yazma
            File.open("out.txt", 'w') {|f| f.write(publishLyricsArray[0]) }
        end

        puts "Artist + Song Name " + publishLyricsArray[0]
        puts "2 Part Lyrics " + publishLyricsArray[1]
        if (publishLyricsArray[0] != "" && publishLyricsArray[1] != "") #lyrics ya da artist ve song boş degilse 1 saat uyu sonra yeniden arama yap
            sleep(20)
        end
    end
   
end
program()

#dosyadan okuyup random arancak şarkıyı seçme kısmı kaldı


  