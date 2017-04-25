$(document).ready(function() {
	$('.multi-item-carousel-main .item').each(function() {
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

		for (var i = 0; i < 3; i++) {
			next = next.next();
			if (!next.length) {
				next = $(this).siblings(':first');
			}

			next.children(':first-child').clone().appendTo($(this));
		}
	});
});