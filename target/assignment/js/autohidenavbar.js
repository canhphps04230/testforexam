// Hide Header on on scroll down
$(document).ready(function() {
	var mainNav = $('#navlist');

	// $(mainNav).hide();

	var myFunction = function() {
		$(window).scroll(function() {
			if ($(this).width() >= 768) {
				if ($(this).scrollTop() >= 20) {
					$(mainNav).fadeOut("slow");
				} else if ($(mainNav).is(':hidden')) {
					$(mainNav).fadeIn("slow");
				}
			} else if ($(mainNav).is(':hidden'))
				$(mainNav).show();
		});
	}

	var myFunctionTest = function() {
		$(window).scroll(function() {
			$(mainNav).show();
			if ($(this).scrollTop() >= 20) {
				$(mainNav).fadeOut("slow");
			}
		});
	}

	var interval = setInterval(myFunction, 3000);

});
