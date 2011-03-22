var toggleVote;

$(document).ready(function() {
	$(".inner .table tr[title]").tooltip({
		opacity: 0.9,
		effect: 'fade',
		offset: [10, -300],
		delay: 30,
		predelay: 2000
	});
	
	toggleVote = function(row) {
		var backgroundColor = $(row).css('background-color');
		var credits = $(row).find('td.cost').text();
		var feature_id = $(row).find('td.id').text();
		if (backgroundColor.indexOf('144, 238, 144') >= 0 || backgroundColor.indexOf('lightgreen') >= 0) {
			// retract vote
			$.post('/votes/create', { credits: credits*-1, feature_id: feature_id }, function(result) {
				if (result.vote.feature_id == feature_id && result.vote.credits < 0) {
					$(row).animate({backgroundColor: 'white'}, 250);
					$(row).find('td.votes').text(result.new_vote_count)//.glow()
					$('span#user_vote_balance').text(result.user_vote_balance).glow();
				}
			});
		} else {
			// vote for feature
			$.post('/votes/create', { credits: credits, feature_id: feature_id }, function(result) {
				if (result.vote.feature_id == feature_id && result.vote.credits > 0) {
					$(row).animate({backgroundColor: 'lightgreen'}, 250);
					$(row).find('td.votes').text(result.new_vote_count)//.glow()
					$('span#user_vote_balance').text(result.user_vote_balance).glow();
				}
			});
		}
	};
});