package weownthenite;

import js.Browser.console;
import js.Browser.document;
import js.Browser.window;
import js.html.VideoElement;

using om.ArrayTools;

class App {

	static var VIDEOS = weownthenite.Build.getVideoFiles();
	static var videoIndex = 0;
	static var video : VideoElement;
	static var words = ['we','own','the','nite'];
	static var wordIndex = 0;

	static function nextVideo() {
		if( ++videoIndex == VIDEOS.length ) videoIndex = 0;
		video.src = 'video/'+VIDEOS[videoIndex];
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
		}

		/*
		window.onload = function() {

			var container = document.querySelector( 'we-own-the-nite' );
			var title = container.querySelector( 'h1.title' );
			var footer = document.body.querySelector( 'footer' );
			var video = container.querySelector( 'video' );

			document.fonts.ready.then( function(_){
				title.style.display = 'block';
			});
			document.body.onblur = function(e){
				//footer.style.opacity = '0';
			}
			document.body.onfocus = function(e){
				//footer.style.opacity = '0.7';
			}

			window.oncontextmenu = e -> {
				e.preventDefault();
			}

			video.oncanplaythrough = e -> {
				video.oncanplaythrough = null;
				video.style.opacity = '1';
			}

			/*
			var links = document.querySelectorAll('a');
			for( link in links ) {
				//console.debug( link );
			}
			* /


		}
		*/
	}

}
