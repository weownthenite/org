package weownthenite;

#if macro
import sys.FileSystem;
#end

class Build {

	macro public static function getVideoFiles() : ExprOf<Array<String>> {
		var path = 'bin/video';
		var arr = FileSystem.readDirectory( path ).filter( function(e){
			return !FileSystem.isDirectory( '$path/$e' );
		});
		return macro $v{arr};
	}

}
