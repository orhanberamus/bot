class Program
    @@size = 500

    table =Array.new(@@size)
    def shifttable(pattern) 

        i= 0
        j = 0
        m = 0
        p = Array.new 
        p = pattern.scan;
        m = pattern.length;
        while i < @@size do
            table[i]=m
            i += 1
        end
        while j < m do
            table[p[j]]=m-1-j
            j += 1
        end
    end
    def horspool(source, pattern)


        s = Array.new
        s = source.scan
        p = Array.new
        p = pattern.scan

        m = pattern.length
        while i = m-1 < source.length do
            k=0
            while k<m && p[m-1-k] == s[i-k] do
                k++
            end
            if k==m 
                pos=i-m+2
               return pos
            else
               i+=table[s[i]]

            i += 1
        end
        return -1

    end
end    
