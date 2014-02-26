<?php
  $db = new PDO('mysql:host=localhost;dbname=testingsystem','root','');//ассоциируем переменную $db с БД testingsystem
	$db->query ('SET NAMES utf8;')
?>