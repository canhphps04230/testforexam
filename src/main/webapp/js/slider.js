$(document).ready(function() {
	// $('.multi-item-carousel').carousel({
	// interval : false
	// });

	// for every slide in carousel, copy the next slide's item in the
	// slide.
	// Do the same for the next, next item.
	// var limit = 2;
	// calLimit = function() {
	// if ($(window).width() < 768)
	// limit = 0;
	// else if ($(window).width() < 992)
	// limit = 1;
	// else
	// limit = 2;
	// }
	//
	// var limitInterval = setInterval(calLimit, 2000);

	$('.multi-item-carousel .item').each(function() {
		var next = $(this).next();
		if (!next.length) {
			next = $(this).siblings(':first');
		}
		next.children(':first-child').clone().appendTo($(this));

		// if (next.next().length > 0) {
		// next.next().children(':first-child')
		// .clone().appendTo($(this));
		// } else {
		// $(this).siblings(':first').children(
		// ':first-child').clone().appendTo(
		// $(this));
		// }
		limit = 2;
		

		for (var i = 0; i < 2; i++) {
			next = next.next();
			if (!next.length) {
				next = $(this).siblings(':first');
			}

			next.children(':first-child').clone().appendTo($(this));
		}
	});	

	
});