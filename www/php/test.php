<?php
	include 'mySqlConnect.php';
	$st=$db->query("INSERT INTO users (fam, name, otch, login, pass, email, lvlAccess, sost) VALUES ('Юзеров','Юзер','Юзерович','user','".sha1('user')."','eqw@eqw.eqw','Пользователь','Активен')");
?>