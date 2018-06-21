package weownthenite;

import js.Browser.console;
import js.Browser.document;
import js.Browser.window;
import js.html.VideoElement;

class App {

	static function main() {

		window.onload = function() {

			var title = document.querySelector( 'header h1' );

			document.fonts.ready.then( function(_){
				title.style.display = 'block';
			});

			var video = document.createVideoElement();
			//video.classList.add( 'background' );
			video.src = 'video/background.mp4';
			video.volume = 0.0;
			video.loop = true;
			video.muted = true;
			video.oncanplaythrough = e -> {
				//video.style.display = 'block';
				video.style.opacity = '1';
				video.play();
			}
			document.body.appendChild( video );

			window.oncontextmenu = e -> e.preventDefault();
			window.onbeforeunload = e -> {
				return null;
			};
		}
	}

}
