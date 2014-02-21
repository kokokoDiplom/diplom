<?php
  //выбирает значения столбца из таблицы problems для вставки в <SELECT>
  include 'mySqlConnect.php';
	// $_POST['fieldName']='problem';
	if (($_POST['fieldName']=='problem')||($_POST['fieldName']=='level')||($_POST['fieldName']=='variant')){ 
		$st=$db->query('SELECT '.$_POST['fieldName'].' FROM problems');
		if ($st) {
		  $mass = array();
  		while ($a=$st->fetch(PDO::FETCH_ASSOC)) array_push($mass, $a[$_POST['fieldName']]);
			echo implode(',', $mass);
		}
	}
	// echo $_POST['fieldName'];
?>