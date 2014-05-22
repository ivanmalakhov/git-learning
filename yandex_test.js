var parsUrl = function (url) {
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