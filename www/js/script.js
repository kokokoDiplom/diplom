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
  setValuesSelect('problem');
	setValuesSelect('level',[document.getElementById('problem').value]);
	setValuesSelect('variant',[document.getElementById('problem').value,document.getElementById('level').value]);
}