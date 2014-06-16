var createNewMessage = function (element) {
	var id = element.attr("id")+'-error';
    $('body').append('<div id = "'+ id +'" class="validation-info"></div>');
    var newmessage = $('#'+id);
    var pos = element.offset(); 
    newmessage.css({
            top: pos.top-3,
            left: pos.left+element.width()+15
    });
	return newmessage;
};
var seterrortype = function (newmessage, element, errormessage){
	if ((typeof(errormessage)!="undefined")){
		newmessage.removeClass('validation-correct').addClass('validation-error').html('←' + errormessage).show();
		element.removeClass('validation-normal').addClass('validation-wrong');
	} else {newmessage.remove();};
	return newmessage;	
}
var setinfotype = function (newmessage, element){
//    newmessage.removeClass('validation-error').addClass('validation-correct').html('√').show();
    element.removeClass('validation-wrong').addClass('validation-normal');
	newmessage.remove();
	return newmessage;
}

$(document).ready(function(){

		$('#send').click(function (){
		        var obj = $('body');
		        obj.animate({ scrollTop: $('#frmPayment').offset().top }, 750, function (){
					 $(":input").each(function (i) {
						 var currentelement = $(this);
						 var error = false;
						 var dataelement = currentelement.data();
                         var newmessage = createNewMessage(currentelement);	
						 // проверка на обязательность заполнения
						 if (dataelement.required){
						 }
						 $.each(dataelement,function(rules,value){
							 if (rules == "required" ){
								if (currentelement.val() == ''){
									error = true;
								};
							 }else if(rules == "regexp"){
								reg = new RegExp(value,"i") 
								if(!reg.test(currentelement.val())){
									error = true;
								}
							 }else if(rules == "length" ){
								if (currentelement.val().length!=value){
									error = true;
								};							 	
							 }else if(rules == "max" ){
								 if (currentelement.val() > value){
									 error = true;
								 }
							 }else if(rules == "min" ){
								 if (currentelement.val() < value){
									 error = true;
								 }							 	
							 } else{};					 	
						 });
						 if (error){
							 seterrortype(newmessage,currentelement,dataelement.error)						 	
						 }else{
							 setinfotype(newmessage,currentelement)	//зеленые галочки						 							 	
						 }
					 });
		        });
		        return false;
		});
});
