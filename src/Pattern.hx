package;

import js.node.Buffer;

class Pattern {

	public static var LEFT = [
      0, 0, 1, 0, 0,
      0, 1, 1, 0, 0,
      1, 1, 0, 0, 0,
      0, 1, 1, 0, 0,
      0, 0, 1, 0, 0,
    ];
	public static var RIGHT = [
      0, 0, 1, 0, 0,
      0, 0, 1, 1, 0,
      0, 0, 0, 1, 1,
      0, 0, 1, 1, 0,
      0, 0, 1, 0, 0,
    ];
	public static var NOISE1 = [
      0, 1, 0, 1, 0,
      1, 0, 1, 0, 1,
      0, 1, 0, 1, 0,
      1, 0, 1, 0, 1,
      0, 1, 0, 1, 0,
    ];
	public static var NOISE2 = [
      1, 0, 1, 0, 1,
      0, 1, 0, 1, 0,
      1, 0, 1, 0, 1,
      0, 1, 0, 1, 0,
      1, 0, 1, 0, 1,
    ];
	public static var DIAMOND = [
      0, 0, 1, 0, 0,
      0, 1, 0, 1, 0,
      1, 0, 0, 0, 1,
      0, 1, 0, 1, 0,
      0, 0, 1, 0, 0,
    ];
	public static var HEART = [
      0, 1, 0, 1, 0,
      1, 1, 1, 1, 1,
      1, 1, 1, 1, 1,
      0, 1, 1, 1, 0,
      0, 0, 1, 0, 0,
    ];

	public function new (){

	}

	/**
	 *  https://github.com/zaccolley/microclicker/blob/master/draw.js
	 */
	function leadingZero(hex){
		return ('00' + hex).substr(-2);
	}

	function binaryStringToHexString(binaryString:String):String {
		return untyped parseInt(binaryString, 2).toString(16).toUpperCase();
	}

	public function createLedMatrixBuffer(input:Array<Int>):Buffer {
		var rowCount = 5;
		var bufferString = '';

		for ( i in 0 ... rowCount ) {
			var matrixRow = input.slice(rowCount * i, rowCount * (i + 1)).join('');
			var hex = binaryStringToHexString(matrixRow);
			bufferString += leadingZero(hex);
		}
		return new Buffer(bufferString, 'hex');
	}

}