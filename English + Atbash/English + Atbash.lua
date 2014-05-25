sT = os.clock();

-- Copied from: http://lua-users.org/lists/lua-l/2004-10/msg00218.html
function ROT13(t)
  local byte_a, byte_A = string.byte('a'), string.byte('A')
  return (string.gsub(t, "[%a]",
      function (char)
        local offset = (char < 'a') and byte_A or byte_a
        local b = string.byte(char) - offset -- 0 to 25
        b = math.fmod(b  + 13, 26) + offset -- Rotate
        return string.char(b)
      end
    ))
end

-- Above code modified for Atbash
function Atbash(t)
  local byte_a, byte_A = string.byte('a'), string.byte('A')
  return (string.gsub(t, "[%a]",
      function (char)
         local offset = (char < 'a') and byte_A or byte_a
         local b = string.byte(char) - offset + 1 -- 1 to 26
         return string.char((26 - b) + offset)
      end
    ))
end

-----------------GENERATE------------------

fName = "Corncob-Dict.txt"

words, i = {}, 1
words_atbash = {}

file = io.open(fName, "r")
for line in file:lines() do

   words[i] = line
   words_atbash[i] = Atbash(line)

   i = i + 1

end
file:close()

---------------FIND COMMON----------------

cnt = 0

file = io.open("Meaningful-Atbash-Words.txt", "w");
for i=1, #words do
   for j=1, #words do
      if words[i] == words_atbash[j] then
         cnt = cnt + 1
         print(cnt, words[i], words_atbash[i])
         file:write(cnt, "  ", words[i], "  ", words_atbash[i], "\n")
      end
   end
   file:flush()
end
file:close()

---------------FIND REVERSE---------------

cnt = 0

file = io.open("Reverse-Atbash-Words.txt", "w");
for i=1, #words do
   if words[i] == string.reverse(words_atbash[i]) then
         cnt = cnt + 1
         print(cnt, words[i], words_atbash[i])
         file:write(cnt, "  ", words[i], "  ", words_atbash[i], "\n")
   end
end
file:close()

eT = os.clock(); print((eT - sT)*1000 .. " msec")
