## PHP (100pt)

First, we find the message showing that `Language was detect automatically :)`

We now know that exploits can be done behind the language param.

By searching vuln for few minutes, we can find out that the language can be changed in `Accept-Encoding` param in the http header.

By trying several types of exploitation, we find out that the headers have RFI exploitation.

Therefore, we get the flag for the challenge using php://filter/ or php://input/.

You can use my `web100.exe` to try them out.

--

## MESSENGERRR (300pt)

First, we were given with the form containing several parameters.

I found out that theme is vulnerable, as the address of the script changes with the theme parameter.


With this, we can attach the image file to theme parameter by putting `theme=../../../upload/~~~(SECUREID-MD5)~~~/aaaa.png?`

By inserting question mark(?) at the end of parameter will avoid from adding .min.css and .min.js.

Now, the problem is executing the javascript.

Since the filtration of image upload is highly restricted, we have to find ways of bypassing the data.

Not only that, it always show "ILLEGAL Exception" error if we just load images in the javascript, as the strings are non-unicode characters.

My assumption was that we can put the first line of header into a variable, and remove all the unwanted data inbetween by commeting them out. (/* and */)

However, it didn't go well in most type of extension, untill we found GIF header.

```
(GIF Format Document: http://www.onicos.com/staff/iz/formats/gif.html)
  0      3 bytes  "GIF"
  3      3 bytes  "87a" or "89a"
  6      2 bytes  <Logical Screen Width>
  8      2 bytes  <Logical Screen Height>
```

In this document, we know that we can modify image width and height.

so I decided to put width as %0a%3d and height as %00%27, and it worked.

In order to prevent another error, I had commented out several things in between, and closed the variable sign at the end of the file.

After that, I have inserted some xss code and sent the image to agent.

```
[2014-03-09 06:35:21] test
[2014-03-09 06:35:26] test
[2014-03-09 06:39:58] __utma=42553126.1733677072.1393760534.1394283233.1394292156.3; __utmc=42553126; __utmz=42553126.1393760534.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); secureid=b5a479424e0142469ae68ef0f0697e34dabd5f8f7ddfa8706d49b41e84608e36
[2014-03-09 06:42:12] secureid=d69e5ccddeed4c2a85fceea286e521fe376433c7e27487f0538598dc27d868ff; flag=RUCTF_48e0945be711468e8cf17164957aeb33
[2014-03-09 11:19:36] 
[2014-03-09 11:19:44] " document.cookie
```
