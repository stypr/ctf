## Forensics 100

there's nothing much to talk about this one; Use your Hex editor to solve the challenge.

`flag{cd69b4957f06cd818d7bf3d61980e291}`

## Forensics 200

Open this file in the wireshark, and then filter `ftp-data` using the filter combo-box.

There would be a downloading packets flowing from here and there.

Right-Click one of them and Click Follow TCP Stream.

Ta-da! save them to see the flag. (since the guy downloads zip file..)

`https://www.cloudshark.org/analysis/044ba74ac4f7/follow?stream=13&proto=tcp (download this file and use wireshark, unzip, and then check the flag)
`

## Forensics 200-2

1) Open PDF

2) Ctrl+A

3) Ctrl+C

4) Ctrl+V

`flag{security_through_obscurity}`

## Forensics 300

it was a quite challenging question because I haven't done forensics for a long period of time..

anyways, we discover few important folders after unzipping the tar files. (i.e. /var/log , /etc/, /var/ww, etc.)

When we look over here and there, we find out that there is a whole list of activities done by root on a file called "/var/log/auth.log"

As we check this log, we see that there is a suspicious log that the hacker writes into a js file all of a sudden.

as we run the js script, we see a pdf file popped up from the browser (in which pdf url is http://128.238.66.100/announcement.pdf)

By extracting the pdf file, you get a small part of js file, and you will get a flag if you run the js script which was embedded in the pdf file.

`/* I didn't save the flag, but if you want to see it, contact me personally (root At stypr D0T com) */`