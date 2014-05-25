# Find meaningful Atbash words

This script was born out of a question on Quora : [Is there a English word, which when coded in Atbash, has a meaning?](http://www.quora.com/Ciphers/Is-there-a-English-word-which-when-coded-in-Atbash-has-a-meaning)

The Wikipedia page for [Atbash](http://en.wikipedia.org/wiki/Atbash) mentions a few words.

The script which read a [list](http://www.mieliestronk.com/corncob_lowercase.txt) of 58110 words and found 42 such words, but as each words is listed twice, there are actually just 21 words:

```
1  all  zoo
2  ark  zip
3  art  zig
4  blip  york
5  girl  trio
6  girth  trigs
7  glib  tory
8  glim  torn
9  glow  told
10  grog  tilt
11  hob  sly
12  hold  slow
13  holy  slob
14  horn  slim
15  ill  roo
16  irk  rip
17  ive  rev
18  levi  over
19  lls  ooh
20  low  old
21  lug  oft
```

The wiki page also mentions words which Atbash into their own reverses, like "wizard" = "draziw". The script found 8 words with this property:

```
1  bevy  yveb
2  by  yb
3  girt  trig
4  grit  tirg
5  hovels  slevoh
6  vole  elov
7  wizard  draziw
8  wold  dlow
```

You can change the dictionary with one that contains more words and try to find other such words. Fair **warning** though: On my machine the script took about 7 minutes to exectue.

