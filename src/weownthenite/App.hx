package weownthenite;

import js.Browser.console;
import js.Browser.document;
import js.Browser.window;
import js.html.VideoElement;

class App {

	static function main() {

		window.onload = function() {

			var container = document.querySelector( 'we-own-the-nite' );
			var title = container.querySelector( 'h1.title' );
			var footer = document.body.querySelector( 'footer' );

			var video = document.createVideoElement();
			video.classList.add( 'background' );
			video.src = 'video/background.mp4';
			video.volume = 0.0;
			video.loop = true;
			video.muted = true;
			video.oncanplaythrough = e -> {
				//video.style.display = 'block';
				video.oncanplaythrough = null;
				video.currentTime = Math.random()*15;
				video.style.opacity = '1';
				video.play();
			}
			container.appendChild( video );

			document.fonts.ready.then( function(_){
				title.style.display = 'block';
			});

			document.body.onblur = function(e){
				//footer.style.opacity = '0';
			}
			document.body.onfocus = function(e){
				//footer.style.opacity = '0.7';
			}

			/*
			var links = document.querySelectorAll('a');
			for( link in links ) {
				//console.debug( link );
			}
			//trace(links);
			*/

			window.oncontextmenu = e -> {
				e.preventDefault();
			}
			/*
			window.onbeforeunload = e -> {
				return null;
			}
			*/

			/*
			window.onscroll = function(e){
				var scrollPos = window.innerHeight+window.scrollY;
				if( scrollPos >= document.body.scrollHeight ) {
					document.querySelector( 'footer' ).classList.remove('hidden');
				} else {
					document.querySelector( 'footer' ).classList.add('hidden');
				}
				//trace(window.innerHeight+window.scrollY, document.body.scrollHeight);
			}
			*/
		}
	}

}
