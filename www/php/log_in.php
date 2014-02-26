<?php
	session_start();
	include 'mySqlConnect.php';
	$mass = Array('index'=>'all','adminka'=>'Администратор','uploadFiles'=>'all','uploadProblems'=>'Администратор');
	if (isset($_SESSION['id'])) {
		$st=$db->prepare("SELECT id, login, pass, lvlAccess FROM users WHERE id=:D");
		$st->bindValue(':D',$_SESSION['id']);
		if (!$st->execute()) var_dump ($st->errorInfo());
		$a=$st->fetch(PDO::FETCH_ASSOC);
		if (!$a) {
			echo 0;
			exit();
		} else {
			$sost=false;
			foreach ($mass as $q=>$v) if (($q==$_POST['filename'])&&(($v==$a['lvlAccess'])||($v=='all'))) $sost=true;
			if ($sost) {
				echo $a['lvlAccess'];
			} else echo 0;
		}
	} else echo 0;
?>