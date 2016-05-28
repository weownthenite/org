package wotn;

#if macro

import haxe.macro.Context;
import haxe.macro.Compiler;
import sys.FileSystem.*;
import sys.io.File.*;
import om.io.FileUtil;
import om.io.FileSync.*;
import om.macro.DefineUtil;
import haxe.Template;

using haxe.io.Path;

class Build {

	static var name : String;
	static var out : String;
	static var context : Dynamic;
	//static var release : Bool;

	static function app() {

		name = 'wotn';
		out = 'out';

		context = {
			name : name
		};

		//Compiler.setOutput( '$out/'+name+'.js' );

		lessc( name, null, DefineUtil.definedValue( 'less-include-path' ) );

		syncDirectory( 'res/font', '$out/font' );
		syncDirectory( 'res/icon', '$out/icon' );
		syncDirectory( 'res/image', '$out/image' );

		syncTemplate( 'res/value/playlist.json', '$out/playlist.json' );
		syncTemplate( 'res/html/index.html', '$out/index.html' );
	}

	static function syncTemplate( src : String, dst : String ) {

		if( !exists( src ) || isDirectory( src ) || !needsUpdate( src, dst ) )
			return false;

		var dir = dst.directory();
		if( !exists( dir ) ) createDirectory( dir );

		var str = new Template( getContent( src ) ).execute( context );
		saveContent( dst, str );

		return true;
	}

	static function lessc( srcName : String, ?dstName : String, ?includePaths : String ) {

		if( dstName == null ) dstName = srcName;
		var srcPath = 'res/style/$srcName.less';
		var dstPath = '$out/$dstName.css';

		var args = [ srcPath, dstPath, '--no-color' ];
		/*
		if( release ) {
			args.push( '-x' );
			args.push( '--clean-css' );
		}
		*/
		if( includePaths != null ) {
			args.push( '--include-path='+includePaths );
		}
		//trace(args);
		var lessc = new sys.io.Process( 'lessc', args );
		var e = lessc.stderr.readAll().toString();
		if( e.length > 0 )
			Context.error( e.toString(), Context.currentPos() );
	}
}

#end
