$(function(){
	var photos = [
		'./img/img4.png',
		'./img/bg-slideshow1.png'
	];
	
	var slideshow = $('#slideShow').bubbleSlideshow(photos);

	$(window).load(function(){
		slideshow.autoAdvance(5000);
	});
	
	// Other valid method calls:
	
	// slideshow.showNext();
	// slideshow.showPrev();
	// slideshow.stopAutoAdvance();
});