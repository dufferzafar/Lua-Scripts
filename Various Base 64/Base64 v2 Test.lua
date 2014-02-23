require("Base64 v2")

sT = os.clock();
   inFile = io.open("KOL.png", "rb")
   data = enc(inFile:read("*all"))
   inFile:close()
eT = os.clock(); print((eT - sT)*1000 .. " msec")

sT = os.clock();
   outFile = io.open("KOL.Out2.png", "wb")
   outFile:write(dec(data))
   outFile:close()
eT = os.clock(); print((eT - sT)*1000 .. " msec")
