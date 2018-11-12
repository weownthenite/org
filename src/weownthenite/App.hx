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
			*/


		}
	}

}
