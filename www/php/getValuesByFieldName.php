<?php
  //выбирает значения столбца из таблицы problems для вставки в <SELECT>
  include 'mySqlConnect.php';
	// $_POST['fieldName']='level';
	// $_POST['fieldsValues']='2';
	if (($_POST['fieldName']=='problem')||($_POST['fieldName']=='level')||($_POST['fieldName']=='variant')){
		if (isset($_POST['fieldsValues'])) {
			$where=' WHERE ';
			$fieldsMass=explode(',',$_POST['fieldsValues']);
			for ($i=0;$i<count($fieldsMass);$i++) {
				switch ($i) {
					case 0: {
					  $param='problem';
						$value=':p';
					} break;
					case 1: {
					  $param='level';
						$value=':l';
					} break;
				}
				$where.=$param."=".$value.(($i<count($fieldsMass)-1)?' and ':'');
			}
		} else $where='';
		$st=$db->prepare('SELECT DISTINCT '.$_POST['fieldName'].' FROM problems '.$where.' ORDER BY '.$_POST['fieldName'].' ASC');
		if (isset($fieldsMass)) {
			$st->bindValue(':p',$fieldsMass[0]);
			if (count($fieldsMass)>1) $st->bindValue(':l',$fieldsMass[1]);
		}
		$st->execute();
		if ($st) {
		  $mass = array();
  		while ($a=$st->fetch(PDO::FETCH_ASSOC)) array_push($mass, $a[$_POST['fieldName']]);
			echo implode(',', $mass);
		}
	}
	// echo $_POST['fieldValue'];
?>