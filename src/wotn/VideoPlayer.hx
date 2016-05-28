package wotn;

import js.Browser.document;
import js.Browser.window;
import js.html.DivElement;
import om.api.youtube.YouTubePlayer;

class VideoPlayer {

	public dynamic function onEvent( e : String ) {}

	public var element(default,null) : DivElement;
	public var isPlaying(default,null) = false;

	var videoId : String;
public	var player : YouTubePlayer;
	var container : DivElement;
//public var overlay : DivElement;

	public function new() {

		element = document.createDivElement();
		element.id = 'videoplayer';
		//element.classList.add( 'channel', 'youtube' );

		container = document.createDivElement();
		//container.classList.add( 'container' );
		container.id = 'videoplayer-container';
		element.appendChild( container );

		//overlay = document.createDivElement();
		//overlay.id = 'videoplayer-overlay';
		////overlay.classList.add( 'overlay' );
		//element.appendChild( overlay );
	}

	public function init( callback : Void->Void ) {
		player = new YouTubePlayer( 'videoplayer-container', {
			width: Std.string( window.screen.width ),
			height: Std.string( window.screen.height ),
			//videoId: videoId,
			playerVars: {
				controls: no,
				color: white,
				autoplay: 0,
				disablekb:0,
				fs: 0,
				iv_load_policy: 3,
				//enablejsapi: 1,
				modestbranding: 1,
				showinfo: 0
			},
			events: {
				'onReady': function(e){
					trace( 'Videoplayer ready' );
					callback();
				},
				'onStateChange': handlePlayerStateChange,
				'onPlaybackQualityChange': handlePlaybackQualityChange,
				'onPlaybackRateChange': handlePlaybackRateChange,
				'onError': handlePlayerError,
				//'onApiChange': handlePlayerAPIChange
			}
		});
		//player.setPlaybackQuality(hd1080);


	}

	public inline function loadPlaylist( id : String ) {
		player.loadPlaylist( id, 0 );
	}

	public inline function load( videoId : String ) {
		player.loadVideoById( videoId );
		//player.cuePlaylist( videoId, 0, 0  );
		/*
		this.videoId = videoId;
		overlay.style.opacity = '1';
		player = new YouTubePlayer( 'videoplayer-container', {
			width: Std.string( window.innerWidth ),
			height: Std.string( window.innerHeight ),
			videoId: videoId,
			playerVars: {
				controls: no,
				color: white,
				autoplay: 1,
				disablekb:0,
				fs: 0,
				iv_load_policy: 3,
				//enablejsapi: 1,
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
		});
		*/
	}

	public inline function stop() {
		//overlay.style.opacity = '1';
		player.stopVideo();
	}

	public inline function setPlaybackQuality( quality : PlaybackQuality ) {
		player.setPlaybackQuality( quality );
	}

	/*
	function handlePlayerReady(e) {
        trace( "player ready "+e );
		//onEvent( 'ready' );
		//player.loadVideoById( videoId );
	}
	*/

	function handlePlayerStateChange(e) {
		//trace(e);
		switch e.data {
		case unstarted:
			isPlaying = false;
			//overlay.style.opacity = '1';
			onEvent( 'stop' );
		case ended:
			isPlaying = false;
			//overlay.style.opacity = '1';
			onEvent( 'end' );
		case playing:
			//overlay.style.display = 'none';
			isPlaying = true;
			//overlay.style.opacity = '0';
			onEvent( 'play' );
		default:
			//overlay.style.display = 'inline-block';
			//overlay.style.opacity = '1';
		}
	}

	function handlePlaybackQualityChange(e) {
		//trace(e);
	}

	function handlePlaybackRateChange(e) {
		//trace(e);
	}

	function handlePlayerError(e) {
		trace(e);
		//onEvent( error( e.data ) );
	}
}
