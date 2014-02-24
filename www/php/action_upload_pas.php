<?php
	//echo '<code><pre>';
	//print_r($_FILES);
	//echo '</pre></code></br>';
	$_POST["user_id"]='1';//test
	$upload_dir = "Z:\home\TestingSystem\www\users_files\\";
	@mkdir($upload_dir, 0777);
	$upload_dir = "Z:\home\TestingSystem\www\users_files\\".$_POST["user_id"];
	@mkdir($upload_dir, 0777);
	$uploadpas = $upload_dir ."\\". basename($_FILES['uploadpas']['name']);
	$flag = true;
if (move_uploaded_file($_FILES['uploadpas']['tmp_name'], $uploadpas))
	{
	echo "Файл *.pas успешно загружен на сервер.\n </br>";	
	foreach ($_FILES['upload_module']['name'] as $key => $value) {
	$upload_module = $upload_dir ."\\". basename($_FILES['upload_module']['name'][$key]);
if (move_uploaded_file($_FILES['upload_module']['tmp_name'][$key], $upload_module) == false)
	{
	$flag = false;
	}
}
if ($flag)
	{
	echo "Модули успешно были загружены на сервер.\n </br>";
	}
  else
	{
	echo "Во время загрузки модулей произошла ошибка.\n </br>";
	}
	//include"convert_file_code.php"; //конвертитуем файл в удобную для нас кодировку
	//модульная часть проверки кода
	
	$name_file = $_FILES['uploadpas']['name'];
	rename($upload_dir."\\".$name_file, $upload_dir."\\myprog.pas");
	//компиляция begin
	$bat_str = 'Z:\home\TestingSystem\www\DOSBox\DOSBox.exe -c "mount d Z:\home\TestingSystem\www\Pascal" -c "mount e '.$upload_dir.'" -securemode -c d:\ -c "bpc.exe e:\myprog.pas /Ue:\ > e:\console.txt" -c exit';
	file_put_contents ($upload_dir."\\".'compiler.bat', $bat_str);
	exec($upload_dir."\\".'compiler.bat');	
	$console_str = file_get_contents ($upload_dir."\\".'console.txt');
	$pattern = '/Error/';
	$error = preg_match($pattern, $console_str);
	if ($error !== 0) {
		echo "Программа не может быть скомпилирована. </br>";
	} else {
		echo "Компиляция прошла успешно. </br>";
	}
	//компиляция end
	}
  else
	{
	echo "Во время загрузки произошла ошибка.\n </br>";
	}
?>