package weownthenite;

import js.Browser.console;
import js.Browser.document;
import js.Browser.window;
import js.html.VideoElement;

using om.ArrayTools;

class App {

	static var VIDEOS = weownthenite.Build.getVideoFiles();
	static var video : VideoElement;
	static var videoIndex = 0;

	static var words = ['we','own','the','nite'];
	static var wordIndex = 0;

	static function nextVideo() {

		if( ++videoIndex == VIDEOS.length ) videoIndex = 0;
		video.src = 'video/'+VIDEOS[videoIndex];

		// Preload next video
		var nextIndex = videoIndex + 1;
		if( nextIndex == VIDEOS.length ) nextIndex = 0;
		var preloadVideo = document.createVideoElement();
		preloadVideo.src = 'video/'+VIDEOS[nextIndex];
	}

	static function main() {

		window.onload = function() {

			VIDEOS.shuffle();

			var header = document.querySelector( 'header' );
			var title = header.querySelector( 'h1' );
			
			/*
			var link = document.createAnchorElement();
			link.textContent = 'hello@weownthenite.org';
			link.href = 'mailto:hello&#64;weownthenite.org';
			link.target = '_blank';
			header.appendChild( link );
			*/

			video = cast document.querySelector( 'video' );
			video.volume = 0.5;

			title.textContent = words[wordIndex];

			/*
			title.onclick = function(){
				title.remove();
				nextVideo();
				window.onclick = function(){
					nextVideo();
				}
			}
			*/

			window.onclick = function(){
				nextVideo();
				if( ++wordIndex == words.length ) wordIndex = 0;
				title.textContent = words[wordIndex];
			}
		
			window.oncontextmenu = function(e){
				e.preventDefault();
				return false;
			}

			/*
			var links = document.querySelectorAll('a');
			for( link in links ) {
				//console.debug( link );
			}
			*/

		}
	}

}
