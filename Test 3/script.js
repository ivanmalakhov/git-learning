var parseUrl = function (url) {
  var result = {}, param, params, QueryString, i;
  if ((url == null) || (url == '')){
    url = 'http://www.amazon.com/Kindle-Paperwhite-Ereader/dp/B00AWH595M/ref=sr_1_1?ie=UTF8&qid=1400766498&sr=8-1&keywords=kindle';
  }
  QueryString = url.split('?')[1];
  if (QueryString != null) {
    params = QueryString.split('&');
    for (i = 0; i < params.length; i++) {
      param = params[i].split('=');
      result[decodeURIComponent(param[0])] = decodeURIComponent(param[1]);
    }
  }
  return result;
};

var createNewUrl = function (anyUrl, params) {
  var existParams = parseUrl(anyUrl); // получаем информацию о существующих параметрах
  var urlObject = document.createElement('a');// формируем объект по имеющейся ссылке
  urlObject.href = anyUrl;
		
  var resultUrl = urlObject.protocol + '//' + urlObject.hostname;

  for (var i in params){
    existParams[i] = params[i]; // Новый массив со старыми и новыми параметрами. Совпадающие параметры перезаписываются
  }
  var resultParams = []; 
  for (var j in existParams){
    resultParams.push(encodeURIComponent(j) + "=" + encodeURIComponent(existParams[j]));
  } 
  return resultUrl + '?' + resultParams.join("&");
}

function compareParams(params1, params2) {
  var paramsStatus = {};
  
  for (var i in params1) if (params1.hasOwnProperty(i)) {
    if (typeof params2[i] != "undefined") {
      if (params1[i] === params2[i]) {
        delete params1[i];
        delete params2[i];
      } else {
        paramsStatus[i] = {
          "status": "changed",
          "oldValue": params1[i],
          "newValue": params2[i]
        };
      }
    } else {
      paramsStatus[i] = {
        "status": "removed",
        "oldValue": params1[i]
      };
    }
  }
  for (var j in params2) if (params2.hasOwnProperty(j)) {
    if (typeof params1[j] == "undefined") {
      paramsStatus[j] = {
        "status": "added",
        "oldValue": params2[i]
      };
    }
  }
  return paramsStatus;
}

function prepareEventHandlers() {
	
  document.getElementById("frmPersonal").onsubmit = function() {

    var params1 = {}, params2 = {}; 
    var i, fieldset,setInput;
    fieldset =document.getElementById('personalInfo');
    setInput = fieldset.getElementsByTagName('input');
    for (i = 0; i < setInput.length; i++) {
      params1[setInput[i].name] = decodeURIComponent(setInput[i].value);
    }

    fieldset =document.getElementById('personalInfo2');
    setInput = fieldset.getElementsByTagName('input');
    for (i = 0; i < setInput.length; i++) {
      params2[setInput[i].name] = decodeURIComponent(setInput[i].value);
    }

    document.getElementById("errorMessage").innerHTML = JSON.stringify(compareParams(params1,params2));		
    return false;
  };
}

window.onload =  function() {
  prepareEventHandlers();
};
