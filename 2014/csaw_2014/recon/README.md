## Reconnaissance 100

well, this was a pretty messed up challenge.
As you know, the guy is an asian and obviously there are dozens of names called "Kevin Chung".

but from the LinkedIn (www.linkedin.com/pub/kevin-chung/50/971/2b3), we see that he has graduated from Staten Island Technical High School.

Thinking about photos before his high school, I guessed that it could be from the photos before his high school (maybe things like orientation, etc.)

After few guesses from his high school website, I was able to find his photo in the 2007 freshman orientation album (http://www.siths.org/apps/album/)

`http://www.siths.org/album/48915/23451.jpg`


## Reconnaissance 100-2

Yet another disturbing challenge. 
I was not able to solve this one until the hint was given.

`HINT: Julian uses OkCupid`

```
http://www.okcupid.com/profile/hockeyinjune?cf=recently_visited
flag{flowers_and_wine_will_get_me}
```

## Reconnaissance 100-3

After massive googling of words like "Fuzyll" and "Dota", I found a page which lists his recent games.

`http://www.dotabuff.com/players/80484382 (Fuzzyl's profile)`

As you see the latest 7 challenges, you may find out that there could be a flag in one of these files.

so as we click these matches, there are several urls popping up with the specific id number of the matcch.

`http://www.dotabuff.com/matches/905521093 (One of the match played by Fuzzyl)`

In order to download these match replays, you may have to use a website like "dotabank".

`http://dotabank.com/replays/matchaddr`

You have to unzip the packed file and start finding flag-like strings from ".dem" files.
Through searching for few matches played recently, you will see a flag in the replay match num == 903461176.

`flag{ComebackIsReal}`