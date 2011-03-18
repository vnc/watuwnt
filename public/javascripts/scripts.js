var toggleVote;

$(document).ready(function() {
	$(".inner .table tr[title]").tooltip({
		opacity: 0.9,
		effect: 'fade',
		offset: [10, -300],
		delay: 30,
		predelay: 1000
	});
	
	toggleVote = function(row) {
		var backgroundColor = $(row).css('background-color');
		var credits = $(row).find('td.cost').text();
		var feature_id = $(row).find('td.id').text();
		if (backgroundColor.indexOf('144, 238, 144') >= 0 || backgroundColor.indexOf('lightgreen') >= 0) {
			$.post('/admin/votes/create', { credits: credits*-1, feature_id: feature_id }, function(result) {
				if (result.feature_id == feature_id && result.credits < 0) {
					$(row).animate({backgroundColor: 'white'}, 250);					
				}
			});
		} else {
			$.post('/admin/votes/create', { credits: credits, feature_id: feature_id }, function(result) {
				if (result.feature_id == feature_id && result.credits > 0) {
					$(row).animate({backgroundColor: 'lightgreen'}, 250);
				}
			});
		}
	};
});