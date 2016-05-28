package wotn;

import js.Browser.console;
import js.Browser.document;
import js.Browser.window;
import js.html.DivElement;
import js.html.ImageElement;
import haxe.Json;
import om.api.youtube.YouTube;
import om.api.youtube.YouTubePlayer;

typedef PlaylistItem = {
	var id : String;
	@:optional var filter : String;
}

class App {

	static inline var PLAYLIST_URL = 'playlist.json';

	static var playlist : Array<PlaylistItem>;
	static var index = 0;
	static var started = false;

	static var video : VideoPlayer;
	static var overlay : DivElement;
	static var title : ImageElement;

	static function loadNextVideo( increaseIndex = true ) {
		if( increaseIndex ) index++;
		if( index == playlist.length ) index = 0;
		var videoId = playlist[index].id;
		trace( 'Loading video[$index][$videoId]' );
		video.load( videoId );
	}

	static function applyVideoFilter( filter = "" ) {
		untyped video.element.style.mozFilter =
		untyped video.element.style.webkitFilter = filter;
	}

	static function resize() {

		var dx = window.screen.width - window.innerWidth;
		var dy = window.screen.height - window.innerHeight;

		video.element.style.width = window.innerWidth+'px';
		video.element.style.height = window.innerHeight+'px';

		video.element.style.left = -Std.int(dx/2)+'px';
		video.element.style.top = -Std.int(dy/2)+'px';
	}

	static function handleVideoPlayerEvent(e) {
		switch e {
		case 'play':
			applyVideoFilter( playlist[index].filter );
			overlay.style.opacity = '0';
		//case 'stop':
		case 'end':
			applyVideoFilter( playlist[index].filter );
			overlay.style.opacity = '1';
			//overlay.style.opacity = 'block';
			loadNextVideo();
		default:
			overlay.style.opacity = '1';
			//overlay.style.opacity = 'block';
		}
	}

	static function handleMouseDown(e) {
		if( !started || video.isPlaying ) {
			overlay.style.opacity = '1';
			started = true;
			loadNextVideo();
		}
	}

	static function handleContextMenu(e) {
		e.preventDefault();
		//toggleFullscreen();
	}

	static function handleWindowResize(e) {
		resize();
	}

	static function main() {

		window.onload = function() {

			var isMobile = om.System.isMobile();
			var body = document.body;

			/*
			if( window.orientation != null ) {
				if( window.orientation == 0 ) {
					//portrait
				} else {
					//landscape
				}
			}
			*/

			YouTube.init( function(){

				title = cast document.getElementById( 'title' );

				video = new VideoPlayer();
				video.onEvent = handleVideoPlayerEvent;
				body.appendChild( video.element );

				overlay = document.createDivElement();
				overlay.id = 'videoplayer-overlay';
				body.appendChild( overlay );

				var req = new haxe.Http( PLAYLIST_URL );
				req.onData = function(str){

					playlist = try Json.parse( str ).playlist catch(e:Dynamic) {
						console.error(e);
						//TODO
						return;
					}

					om.util.ArrayUtil.shuffle( playlist );

					video.init( function(){

						var maxScreenSize = Math.max( window.screen.width, window.screen.height );
						var bestPlaybackQuality = switch maxScreenSize {
							case i if(i>1280): hd1080;
							case i if(i>1024): hd720;
							default: large;
						}
						trace( 'Set playback quality: '+bestPlaybackQuality );
						video.setPlaybackQuality( bestPlaybackQuality );

						resize();

						if( !isMobile ) {
							started = true;
							video.load( playlist[0].id );
							//video.loadPlaylist( 'PL0FskzBvijeFbxAOAje9D4wr9TQiG' );
						}

						window.addEventListener( 'resize', handleWindowResize, false );
						window.addEventListener( 'contextmenu', handleContextMenu, false );
						overlay.addEventListener( 'mousedown', handleMouseDown, false );
					});
				};
				req.onError = function(e){
					trace(e);
				};
				req.request();
			});
		}
	}
}
