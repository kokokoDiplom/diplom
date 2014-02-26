//конструктор объекта xmlHTTPRequert для использования технологии AJAX
function getXmlHttpRequest(){
	try {
		return new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			return new ActiveXObject("Microsoft.XMLHTTP");
		} catch (ee) {}
}
	if (typeof XMLHttpRequest!='undefined') {
		return new XMLHttpRequest();
	}
}

function removeChildren(node) {
	var children = node.childNodes;
	if (typeof children!="undefined")	while (children.length) node.removeChild(children[0]);
}


function getValuesByField(fieldName, fieldsValues){
	var xmlHTTP = getXmlHttpRequest();
	var strFieldsValues='&fieldsValues=';
	if (typeof fieldsValues!="undefined") {
	  strFieldsValues+=fieldsValues.join(',');
	} else strFieldsValues=''; 
	xmlHTTP.open("POST","php/getValuesByFieldName.php",false);
	xmlHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHTTP.send('fieldName='+fieldName+strFieldsValues);
	if (xmlHTTP.responseText!=0) return xmlHTTP.responseText.split(',');		
}

function setOption(select, item){
	var option = document.createElement('option');
	option.innerHTML=item;
	select.appendChild(option);
}

//берет из базы данных записи и пихает их в select c id=fieldName fieldsValues - массив со значениями полей для выборки поля fieldName
function setValuesSelect(fieldName, fieldsValues){
  var mass = getValuesByField(fieldName, fieldsValues);
  var select = document.getElementById(fieldName);
	removeChildren(select);
	for (var i=0; i<mass.length; i++) setOption(select, mass[i]);
}

function changeProblem() {
	setValuesSelect('level',[document.getElementById('problem').value])
	setValuesSelect('variant',[document.getElementById('problem').value,document.getElementById('level').value]);
}

function onLoadFunction(){
  if (checkAccess()) {
		setValuesSelect('problem');
		setValuesSelect('level',[document.getElementById('problem').value]);
		setValuesSelect('variant',[document.getElementById('problem').value,document.getElementById('level').value]);
	}
}

function getFileName(){//имя инсполняемой страницы
	var st = unescape(window.location.href);
	var r = st.substring(st.lastIndexOf('/')+1,st.length);
	return r.substring(0,r.lastIndexOf('.'));
}

function checkAccess(){//проверка доступа
	var xmlHTTP = getXmlHttpRequest();
	xmlHTTP.open("POST","php/log_in.php",false);
	xmlHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	var fileName=getFileName();
	xmlHTTP.send('filename='+fileName);
	// fileName
	if (xmlHTTP.responseText==0) {
		window.location='index.html';
	} else return true;
}

function auth(){//авторизация
	var login = document.getElementById('login'),pass = document.getElementById('pass');
	if ((login.value!='')&&(pass.value!='')) {
		var xmlHTTP = getXmlHttpRequest();
		xmlHTTP.open("POST","php/auth.php",false);
		xmlHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xmlHTTP.send('login='+login.value+'&pass='+pass.value);
		var xmlAnswer = xmlHTTP.responseText;
		if (xmlAnswer=='1') {
			window.location='uploadFiles.html';
		} else var class1='neok', s='Введены неверные логин/пароль';
	} else {
		var class1='neok', s='';
		if (login.value=='') s+='Не заполнено поле ЛОГИН<br>';
		if (pass.value=='') s+='Не заполнено поле ПАРОЛЬ<br>';
	}
	error_unerror(class1,s);
}

function error_unerror(class1,s){//добавляет в документ блок div с классов class1 и содержимым s
	var div = document.createElement('div');
	div.setAttribute('class',class1);
	div.setAttribute('id','error_unerror');
	div.innerHTML=s;
	var err = document.getElementById('error_unerror');
	if (err!==null)	err.parentNode.removeChild(err);
	document.body.appendChild(div);
}