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

function getValuesByField(fieldName){
	var xmlHTTP = getXmlHttpRequest();
	xmlHTTP.open("POST","php/getValuesByFieldName.php",false);
	xmlHTTP.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHTTP.send('fieldName='+fieldName);
	if (xmlHTTP.responseText!=0) return xmlHTTP.responseText.split(',');		
}

function setOption(select, item){
	var option = document.createElement('option');
	option.innerHTML=item;
	select.appendChild(option);
}

//берет из базы данных записи и пихает их в select c id='select'+fieldName
function setValuesSelect(fieldName){
  var mass = getValuesByField(fieldName);
  var select = document.getElementById(fieldName);
	for (var i=0; i<mass.length; i++) setOption(select, mass[i]);
}

function setValuesSelectProblems(){
  setValuesSelect('problem');
	setValuesSelect('level');
	setValuesSelect('variant');
}