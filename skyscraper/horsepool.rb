class Program
    

    @@m = pattern.length
    @@n = lyrics.length

    

    def horsepool(lyrics,pattern)

        table = generateShiftTable(pattern) #generate Table of shifts

        i = @@m − 1 #position of the pattern’s right 
        while i <= @@n − 1
            k = 0 #number of matched characters
            while k <= @@m − 1 and pattern[@@m − 1− k] == lyrics [i − k]
                k = k + 1
            end    
            if k == @@m
                return i − @@m + 1
            else 
                i = i + table[lyrics [i]]    
        end        
        return −1
    end

    def generateShiftTable(pattern)
        i = 0
        j= 0
        size = 500
        table []
        while i < size  do
           table[i] = @@m
           i +=1
        end
        while j < @@m  do
           table[pattern[j]] = @@m - 1 - j;
           j += 1
        end

        return table    
    end 
end
lyrics = "merhaba [Verse] burasi"
pattern = "[Verse]" 
program = Program.new()
sonuc = program.horsepool(lyrics,pattern)

puts sonuc    