<?php
	session_start();
	include 'mySqlConnect.php';
	$st=$db->prepare("SELECT * FROM users WHERE login=:log and pass=:p");
	$st->bindValue(':log',$_POST['login'],PDO::PARAM_STR);
	$st->bindValue(':p',sha1($_POST['pass']));
	if (!$st->execute()) var_dump ($st->errorInfo());
	$a=$st->fetch(PDO::FETCH_ASSOC);
	if ($a===false) {
		echo 0;
	} else {
		$_SESSION['id']=$a['id'];
		echo 1;
	}
?>