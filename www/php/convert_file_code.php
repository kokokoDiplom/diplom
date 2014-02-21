<?php
	$fp = fopen($uploadfile,"r"); // Получаем содержимое файла
    $file = file($uploadfile);// Получить содержимое файла в виде одной строки	
	fclose($fp);	
	foreach ($file as $key => $value) {	
	$file_iconv[] = iconv('CP866', "utf-8", $value); // Преобразовывает символы строки в другую кодировку
	}	
	$file = $file_iconv;
    // Вывод содержимого файла с кодировкой UTF-8
    echo '<code><pre>';
	print_r($file);
	echo '</pre></code>';
?>