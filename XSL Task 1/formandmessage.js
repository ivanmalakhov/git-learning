/*function prepareEventHandlers() {
	
  document.getElementById("frmPayment").onsubmit = function() {
	  	
  };
}

window.onload =  function() {
  prepareEventHandlers();
};
*/
$(document).ready(function(){

	var jVal = {
                'tempAccount' : function() {
                        $('body').append('<div id="nameInfo" class="validation-info"></div>');
                        var nameInfo = $('#nameInfo');
                        var ele = $('#tempAccount');
                        var pos = ele.offset();
                        nameInfo.css({
                                top: pos.top-3,
                                left: pos.left+ele.width()+15
                        });
                        if(ele.val().length < 6) {
                                jVal.errors = true;
                                        nameInfo.removeClass('validation-correct').addClass('validation-error').html('← at least 6 characters').show();
                                        ele.removeClass('validation-normal').addClass('validation-wrong');
                        } else {
                                        nameInfo.removeClass('validation-error').addClass('validation-correct').html('√').show();
                                        ele.removeClass('validation-wrong').addClass('validation-normal');
                        }
                },
				'sendIt' : function (){
						if(!jVal.errors) {
							$('#frmPayment').submit();
						}
				}
        };
		$('#send').click(function (){
		        var obj = $('body');
		        obj.animate({ scrollTop: $('#frmPayment').offset().top }, 750, function (){
					 $(":input").each(function (i) {
						 var currentelement = $(this);
						 var dataelement = currentelement.data();

                         $('body').append('<div id="nameInfo" class="validation-info"></div>');
                         var nameInfo = $('#nameInfo');
                         var pos = currentelement.offset(); 
                         nameInfo.css({
                                 top: pos.top-3,
                                 left: pos.left+currentelement.width()+15
                         });	

						 if (dataelement.required){
							 if (currentelement.val() == ''){
                                 nameInfo.removeClass('validation-correct').addClass('validation-error').html('← Пусто').show();
                                 currentelement.removeClass('validation-normal').addClass('validation-wrong');
							 }else{
                                 nameInfo.removeClass('validation-error').addClass('validation-correct').html('√').show();
                                 currentelement.removeClass('validation-wrong').addClass('validation-normal');
							 	
							 }
							 
						 }
						 $.each(dataelement,function(j,val){
							 alert(j + ";" + val);						 	
						 });
						 alert($(this).val());
					 });
		                jVal.errors = false;
		                jVal.tempAccount();
		                jVal.sendIt();
		        });
		        return false;
		});
      //  $('#TempAccount').change(jVal.TempAccount);
});
