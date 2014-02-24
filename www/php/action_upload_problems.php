<?php
	////////////// создаём на сервере папку с именем/номером задачи
	$problem_name = $_POST["number_problem"].'_'.$_POST["number_level"].'_'.$_POST["number_variant"];	
	$upload_dir = "Z:\home\TestingSystem\www\problems\\";
	@mkdir($upload_dir, 0777);
	$upload_dir = "Z:\home\TestingSystem\www\problems\\".$problem_name;
	@mkdir($upload_dir, 0777);	
	$flag = true;
	////////////// загружаем файлы text.txt, input*.txt и pattern*.txt в эту папку на сервере
	$upload_text_problem = $upload_dir ."\\". basename($_FILES['upload_text_problem']['name']);
	if (move_uploaded_file($_FILES['upload_text_problem']['tmp_name'], $upload_text_problem) == false)
	{
	$flag = false;
	}
	foreach ($_FILES['upload_input']['name'] as $key => $value) {
	$upload_input = $upload_dir ."\\". basename($_FILES['upload_input']['name'][$key]);
	if (move_uploaded_file($_FILES['upload_input']['tmp_name'][$key], $upload_input) == false)
	{
	$flag = false;
	}
	}
	foreach ($_FILES['upload_pattern']['name'] as $key => $value) {
	$upload_pattern = $upload_dir ."\\". basename($_FILES['upload_pattern']['name'][$key]);
	if (move_uploaded_file($_FILES['upload_pattern']['tmp_name'][$key], $upload_pattern) == false)
	{
	$flag = false;
	}
	}	
	if ($flag)
	{
	echo 'файлы успешно были загружены на сервер. </br>';
	////////////// открываем файл с текстом задачи для дальнейшей загрузки на сервер
	if  ($_POST["option1"] == 'windows-1251') {
	$fp = fopen($upload_text_problem,"r"); // Получаем содержимое файла
    $file = file($upload_text_problem);// Получить содержимое файла в виде одной строки	
	$file = file_get_contents($upload_text_problem);
	fclose($fp);	
	$file = iconv('Windows-1251', "Utf-8", $file); 
	}
	////////////// загружаем номер задачи и текст задачи в БД
	include 'mySqlConnect.php';
	$st=$db->prepare("INSERT INTO problems (problem,level,variant,text_problem) VALUES (:p, :l, :v, :t)");
	$st->bindValue(':p',$_POST['number_problem']);
	$st->bindValue(':l',$_POST['number_level']);
	$st->bindValue(':v',$_POST['number_variant']);
	$st->bindValue(':t',$file);
	if (!$st->execute()) var_dump ($st->errorInfo());	
	}
  else
	{
	echo 'Во время загрузки файлов произошла ошибка. </br>';
	}
?>