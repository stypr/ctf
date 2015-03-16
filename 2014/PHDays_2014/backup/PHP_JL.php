<?php

print <<<PAGE
<html>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.2/css/bootstrap.min.css" rel="stylesheet">
<link href="//netdna.bootstrapcdn.com/bootswatch/3.0.2/cyborg/bootstrap.min.css" rel="stylesheet">
<body>
    <div class="jumbotron">
      <div class="container">
        <h1>You data was encrypted and stored in Detcelfer Data Prison</h1>
        <p>This is a prison for stolen data from victim's computers. Pay us 31,337 BTC to get back your data or we will delete it. You have only two days for it, so don't waste your time</p>
        <p><a class="btn btn-primary btn-lg" role="button">Pay now &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <h2>Seriously</h2>
          <p>Don't try to cheat us. Don't forget who has the better case now!</p>
          <p><a class="btn btn-default" href="#" role="button">Pay us &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Unbreakable</h2>
          <p>Our prison is the best prison in the world. There is no byte leaked from our prison</p>
          <p><a class="btn btn-default" href="#" role="button">Pay us &raquo;</a></p>
       </div>
        <div class="col-md-4">
          <h2>Our data center works for you</h2>
          <p>We build, maintain and operate our own data centers, and have a deep understanding of your infrastructure from the ground up. That means less finger pointing, more accountability and more reliability.</p>
          <p><a class="btn btn-default" href="#" role="button">Pay us &raquo;</a></p>
        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; Detcelfer PHDays 2013-2014</p>
      </footer>
    </div> 
</body>
</html>
<!--
PAGE;

$get_password_hash = function( $filename){
	return hash('sha512',file_get_contents($filename, false, NULL, 0, 32));
};

$file_path= "/home/phd/password";

$evil = '/=|function|class|for|foreach|while|die|exit|eval|print|echo|unset|isset|empty/i';
if (preg_match($evil,$_GET['code']) ){
	die("Don't try to cheat me!");
}
$user_pass = eval($_GET['code']);


if (empty($user_pass)){
	die("Empty value");
}

if ($user_pass !== $get_password_hash( $file_path))
    die("Invalid password");
else 
    die(file_get_contents('./admin.php'));
?>
