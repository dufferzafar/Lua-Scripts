require("Base64 v3")

sT = os.clock();
   inFile = io.open("KOL.png", "rb")
   data = to_base64(inFile:read("*all"))
   inFile:close()
eT = os.clock(); print((eT - sT)*1000 .. " msec")

sT = os.clock();
   outFile = io.open("KOL.Out3.png", "wb")
   outFile:write(from_base64(data))
   outFile:close()
eT = os.clock(); print((eT - sT)*1000 .. " msec")
