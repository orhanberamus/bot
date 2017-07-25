
def pickLyrics(lyrics)
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
              count+= 1
            end
            i += 1
        end
    end
    stringpart = part.join("")
    stringpart.gsub!('{','\n')
    puts stringpart
end
lyrics = 
"{Intro{
Dirty soda, Spike Lee{
White girl, Ice T{
Fully loaded AP, yeah{

[Hook]
I just fucked your bitch in some Gucci flip flops
I just had some bitches and I made 'em lip lock
I just took a piss and I seen codeine coming out
We got purple Actavis, I thought it was a drought


"

pickLyrics(lyrics)