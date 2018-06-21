package weownthenite;

import js.Browser.console;
import js.Browser.document;
import js.Browser.window;
import js.html.VideoElement;

class App {

	static function main() {

		window.onload = function() {

			console.info( 'W3 0WN 7H3 N173' );

			//var title = document.getElementById( 'title' );
			var title = document.querySelector( 'header h1' );

			//var video : VideoElement = cast document.getElementById( 'video' );
			var video = document.createVideoElement();
			video.id = 'video';
			//video.classList.add( 'background' );
			video.src = 'video/background.mp4';
			video.volume = 0.0;
			video.loop = true;
			video.muted = true;
			video.oncanplaythrough = function(){
				title.style.display = 'block';
				//video.style.display = 'block';
				video.style.opacity = '1';
				video.play();
			}
			document.body.appendChild( video );

			video.requestPointerLock();

			//var overlay = document.getElementById( 'overlay' );
			//overlay.style.backgroundColor = '#fff';
			/*
			var video = document.createVideoElement();
			video.classList.add( 'background' );
			video.src = 'video/fuga.mp4';
			video.volume = 0;
			video.loop = true;
			video.addEventListener( 'canplaythrough', function(){
				document.getElementById( 'preload' ).remove();
				video.play();
			} );
			document.body.appendChild( video );
			*/

			window.oncontextmenu = e -> e.preventDefault();
			window.onbeforeunload = e -> {
				return null;
			}


			/*
			var isMobile = om.System.isMobile();
			var body = document.body;

			YouTube.init( function(){

				trace( "Youtube ready" );

				player = new YouTubePlayer( 'youtube-player',
					{
	                	width: window.innerWidth,
	                	height: window.innerHeight,
	                	//videoId: id,
						//autoplay: 1,
	                	playerVars: {
	                    	controls: 0,
	                    	autoplay: 0,
	                    	disablekb:0,
	                    	fs: 0,
	                    	color: 'black',
	                    	//enablejsapi: 1,
	                    	modestbranding: 1,
	                    	showinfo: 0
	                	},
	                	events: {
	                    	'onReady': function(e){
								player.setVolume( 0 );
								player.loadVideoById('SRGapYmBK2E');
							},
	                    	'onStateChange': function(e){
							},
	                    	'onPlaybackQualityChange': function(e){
							},
	                    	'onPlaybackRateChange': function(e){
							},
	                    	'onError': function(e){
							},
		                    //'onApiChange': handlePlayerAPIChange
	                	}
	            	}
				);

				window.onresize = function(e){
					player.setSize( window.innerWidth, window.innerHeight );
				}
				*/
		};
	}
}
