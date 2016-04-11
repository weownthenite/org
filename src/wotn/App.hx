package wotn;

import js.Browser.document;
import js.Browser.window;
import js.html.ImageElement;
import js.html.DivElement;
import om.api.YouTube;
import om.api.YouTubePlayer;
import haxe.Json;

using om.util.ArrayUtil;

typedef Video = {
	var id : String;
	var filter : String;
}

class App {

	static inline var PLAYLIST_URL = 'playlist.json';

	static var title : ImageElement;
	static var player : YouTubePlayer;
	static var overlay : DivElement;

	static var playlist: Array<Video>;
	static var playlistIndex = 0;
	static var isPlaying = false;

	static function handlePlayerReady(e) {
		player.setPlaybackQuality( highres );
		player.playVideo();
    }

    static function handlePlayerStateChange(e) {
		var titleBlendmode = 'none';
        switch e.data {
        case unstarted:
        case ended:
			isPlaying = false;
			loadNextVideo();
			overlay.style.opacity = '1';
	//		playerContainer.style.opacity = '0';
        case playing:
			player.c.style.opacity = '1';
			isPlaying = true;
            //playerOverlay.style.opacity = '0';
            //onEvent( 'playing' );
			overlay.style.opacity = '0';
	//		playerContainer.style.opacity = '1';
			titleBlendmode = 'overlay';
			//untyped player.c.style.webkitFilter = 'invert(100%)';
        case paused:
        case buffering:
        case video_cued:
        }
		untyped title.style.mixBlendMode = titleBlendmode;
    }

    static function handlePlaybackQualityChange(e) {
        trace(e);
    }

    static function handlePlaybackRateChange(e) {
        trace(e);
    }

    static function handlePlayerError(e) {
        trace(e);
    }

    static function handlePlayerAPIChange(e) {
        trace(e);
    }

	static function handleClick() {
		loadNextVideo();
	}

	static function loadNextVideo() {
		if( playlistIndex++ == playlist.length )
			playlistIndex = 0;
		player.c.style.opacity = '0';
		overlay.style.opacity = '1';
		player.loadVideoById( playlist[playlistIndex].id );
	}

	static function setPlayerSize( ?w : Int, ?h : Int ) {
		if( w == null ) w = window.innerWidth;
		if( h == null ) h = window.innerHeight;
		player.c.style.width = w+'px';
		player.c.style.height = h+'px';
		player.setSize( w, h );
	}

	static function toggleFullscreen() {
		if( document.fullscreenElement == null ) {
			untyped document.body.webkitRequestFullscreen();
		} else {
			untyped document.webkitExitFullscreen();
		}
	}

	static function update( time : Float ) {
		window.requestAnimationFrame( update );
	}

	static function handleYouTubeReady() {

		document.getElementById( 'loader' ).remove();

		var width = window.innerWidth;
		var height = window.innerHeight;

		var player = App.player = new YouTubePlayer( 'videoplayer',
			{
				width: '$width',
				height: '$height',
				videoId: playlist[playlistIndex].id,
				playerVars: {
					autoplay: 1,
					controls: no,
					color: white,
					//enablejsapi: 1,
					fs: 0,
					iv_load_policy: 3,
					//loop: 1,
					modestbranding: 1,
					showinfo: 0
				},
				events: {
					'onReady': handlePlayerReady,
					'onStateChange': handlePlayerStateChange,
					'onPlaybackQualityChange': handlePlaybackQualityChange,
					'onPlaybackRateChange': handlePlaybackRateChange,
					'onError': handlePlayerError,
					//'onApiChange': handlePlayerAPIChange
				}
			}
		);

		setPlayerSize( width, height );

		overlay.onclick = function(){
			if( isPlaying ) loadNextVideo();
		}

		document.body.addEventListener( 'dblclick', handleDoubleClick, false );

		//window.requestAnimationFrame( update );
		//trace(untyped player.c.contentDocument.body.);

		/*
		var audio = new js.html.audio.AudioContext();
		var analyser = audio.createAnalyser();
		analyser.fftSize = 256;

		var source = audio.createMediaElementSource( cast player.c ); // this is where we hook up the <audio> element
		source.connect(analyser);
		analyser.connect( audio .destination);
		var sampleAudioStream = function() {
		};
		var timer = new haxe.Timer(100);
		timer.run = sampleAudioStream;
		*/
	}

	static function handleContextMenu(e) {
		e.preventDefault();
		toggleFullscreen();
	}

	static function handleDoubleClick(e) {
		e.preventDefault();
		toggleFullscreen();
	}

	static function handleWindowResize(e) {
		setPlayerSize();
	}

    static function main() {

		window.onload = function() {

			var isMobile = om.System.isMobile();

			if( isMobile ) {
				document.body.textContent = 'NOPE, DESKTOP ONLY';
				return;
			}

			title = cast document.getElementById( 'title' );
			//title.style.opacity = '1';

			overlay = cast document.getElementById( 'overlay' );

			var req = new haxe.Http( PLAYLIST_URL );
			req.onData = function(str){

				var data : Array<Dynamic> = try Json.parse( str ).playlist catch(e:Dynamic){
					document.body.innerHTML = e;
					return;
				}
				playlist = [];
				for( track in data ) playlist.push( track );
				playlist.shuffle();

				YouTube.init( handleYouTubeReady );
			};
			req.request();

			window.addEventListener( 'resize', handleWindowResize, false );
			window.addEventListener( 'contextmenu', handleContextMenu, false );



			//player.setAttribute( 'src', streamUrl );


		}
    }
}
