$(document).ready(function() {
	// make check all work
	$("#checkAll").click(function() {
		var $that = $(this);
		$(':checkbox').each(function(){
			this.checked = $that.is(':checked');
		});
		
		if ($that.is(':checked')) {
			$('#btnDelete').removeAttr('disabled');
		} else {
			$('#btnDelete').attr('disabled', true);
		}
	});
	// check at least one checkbox is checked
	$('input[type="checkbox"][name="idCheck"]').on('change', function() {
		$("#checkAll").prop('checked', false);
		var getArrVal = $('input[type="checkbox"][name="idCheck"]:checked');
	
	if (getArrVal.length > 0) {
		$('#btnDelete').attr('disabled', true);
	} else {
		$('#btnDelete').removeAttr('disabled');
	}
		
	});
})
