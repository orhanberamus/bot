
artist = "Tove Lo";
song = "Memories";
toWriteString = artist + "\n" + song;

File.open("out.txt", 'w') {|f| f.write(toWriteString) }