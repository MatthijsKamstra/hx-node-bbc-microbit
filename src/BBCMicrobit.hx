package;

import js.Error;
import haxe.extern.EitherType;
import js.node.Buffer;

@:enum abstract Period(Int) {
	// Read or write the period. Support values are: 1, 2, 5, 10, 20, 80, 160, or 640 ms.
	var NR_1 = 1;
	var NR_2 = 2;
	var NR_5 = 5;
	var NR_10 = 0;
	var NR_20 = 20;
	var NR_80 = 80;
	var NR_160 = 160;
	var NR_640 = 640;
}
@:enum abstract EventName(String) {
	var EVENT = 'event';
	var BUTTON_A_CHANGE = 'buttonAChange';
	var BUTTON_B_CHANGE = 'buttonBChange';
	var ACCELEROMETERCHANGE = 'accelerometerChange';
	var MAGNETOMETERBEARINGCHANGE = 'magnetometerBearingChange';
	var MAGNETOMETERCHANGE = 'magnetometerChange';
	var TEMPERATURECHANGE = 'temperatureChange';
	var PINDATACHANGE = 'pinDataChange';
	var DISCONNECT = 'disconnect';
}
@:enum abstract FixValue(Int) {
	var NR_0 = 0; // false
	var NR_1 = 1; // true
	var FALSE = 0;
	var TRUE = 1;
	var IS_ON = 0;
	var IS_OFF = 1;
}
@:enum abstract PinValue(Int) from Int to Int {
	var P0 = 0;
	var P1 = 1;
	var P2 = 2;
	var P3 = 3;
	var P4 = 4;
	var P5_writeonly = 5;
	var P6_writeonly = 6;
	var P7_writeonly = 7;
	var P8_writeonly = 8;
	var P9_writeonly = 9;
	var P10 = 10;
	var P11_writeonly = 11;
	var P12_writeonly = 12;
	var P13_writeonly = 13;
	var P14_writeonly = 14;
	var P15_writeonly = 15;
	var P16_writeonly = 16;
	var P17_writeonly = 17;
	var P18_writeonly = 18;
	var P19_writeonly = 19;
	var P20_writeonly = 20;
}

/**
 * The Micro Bit (also referred to as BBC Micro Bit, stylized as micro:bit)
 * is an ARM-based embedded system designed by the BBC for use in computer education in the UK.
 *
 * @source http://microbit.org/index/
 * @source https://github.com/sandeepmistry/node-bbc-microbit
 */
@:jsRequire("bbc-microbit")
extern class BBCMicrobit {

	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#discovery
	static function discover(callback:MicrobitObj->Void):Void;
	static function discoverAll(callback:MicrobitObj->Void):Void;
	static function stopDiscover(callback:MicrobitObj->Void):Void;
	static function stopDiscoverAll(callback:MicrobitObj->Void):Void;
	static function discoverById(id:String, callback:MicrobitObj->Void):Void;
	static function discoverByAddress(address:String, callback:MicrobitObj->Void):Void;
	static function discoverWithFilter(filter:String, callback:MicrobitObj->Void):Void;
	static function stopScanning():Void;
	static function startScanning():Void;

	/**
	 *  test this extern (but quite useless!!!)
	 *
	 *  @param str value you want to trace
	 */
	public static inline function trace (str:String):Void{
		trace('$str');
	}

	/**
	 *  Send an analog (0 to 1023) value to pin
	 *
	 *  @param m 			microbit
	 *  @param pin 			pin 0 to 20
	 *  @param value 		value from 0 to 255
	 *  @param callback 	(optional) callback function
	 */
	public static inline function writeAnalogPin(m:MicrobitObj,pin:EitherType<Int,PinValue>, value:Int, ?callback:Void->Void):Void{
		m.pinOutput(pin, function(){
			trace('[writeAnalog] pinOutput - pin:$pin, value:$value');
			m.pinAnalog(pin, function(){
				trace('[writeAnalog] pinAnalog - pin:$pin, value:$value');
				if(value < 0 ) value = 0;
				if(value > 255) value = 255;
				m.writePin(pin,value, function (){
					trace('[writeAnalog] writePin - pin:$pin, value:$value');
					if(callback!=null) callback();
				});
			});
		});
	}

	/**
	 *  Send a digital (0,1) value to pin
	 *
	 *  @param m 			microbit
	 *  @param pin 			pin 0 to 20
	 *  @param value 		fixedValue is either 0 or 1
	 *  @param callback 	(optional) callback function
	 */
	public static inline function writeDigitalPin(m:MicrobitObj,pin:PinValue, value:FixValue, ?callback:Void->Void):Void{
		m.pinOutput(pin, function(){
			trace('[writeDigital] pinOutput');
			m.pinDigital(pin, function(){
				trace('[writeDigital] pinDigital');
				m.writePin(pin,value, function (){
					trace('[writeDigital] writePin');
					if(callback!=null)callback();
				});
			});
		});
	}

}

// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md

extern class MicrobitObj {

	public var id: String;
	public var address: String;

	// @:overload(function( event:EitherType<String,EventName>, callback:String->Void):Void {})
	@:overload(function( event:EitherType<String,EventName>, callback:Int->Int->Int->Void):Void {})
	@:overload(function( event:EitherType<String,EventName>, callback:Int->Dynamic->Void):Void {})
	@:overload(function( event:EitherType<String,EventName>, callback:Int->Void):Void {})
	public function on( event:EitherType<String,EventName>, callback:Void->Void):Void;

	public function once( event:EitherType<String,EventName>, callback:Void -> Void):Void;

	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#connecting-and-disconnecting
	public function connectAndSetUp(callback:Void->Void):Void; // error?
	public function disconnect(?callback:Void->Void):Void;
	// device information
	public function readDeviceName(callback : Error->String->Void):Void;
	public function readModelNumber(callback : Error->String->Void):Void;
	public function readSerialNumber(callback : Error->String->Void):Void;
	public function readFirmwareRevision(callback : Error->String->Void):Void;


	// button-service
	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#buttons
	public function EventNameButtons(callback:Void->Void):Void;
	public function unEventNameButtons(callback:Void->Void):Void;
	public function EventNameButtonA(callback:Void->Void):Void;
	public function unEventNameButtonA(callback:Void->Void):Void;
	public function EventNameButtonB(callback:Void->Void):Void;
	public function unEventNameButtonB(callback:Void->Void):Void;
	public function subscribeButtons(callback:Void->Void):Void;

	public function EventNameEvents(id:Int, value:Int, callback:Void->Void):Dynamic;
	@:overload(function (id:Int, value:Int, callback:Error->Void):Dynamic {})
	public function subscribeEvents(id:Int, value:Int, callback:Void->Void):Dynamic;


	// led-service
	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#led-matrix
	@:overload(function (callback:Error->Dynamic->Void):Void {})
	public function readLedMatrixState(callback:Void->Void):Void;
	public function writeLedMatrixState(data:Buffer, callback:Void->Void):Void;
	// text is a string that must be 20 characters or less
	public function writeLedText(text:String, ?callback:Void->Void):Void;
	public function readLedScrollingDelay(callback:Void->Void):Void;
	public function writeLedScrollingDelay(delay:Int, callback:Void->Void):Void;

	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#accelerometer
	// Read or write the period. Support values are: 1, 2, 5, 10, 20, 80, 160, or 640 ms.
	public function readAccelerometerPeriod(callback:Error->Int):Void;
	public function writeAccelerometerPeriod(period:EitherType<Int,Period>, callback:Error->Void):Void;

	public function readAccelerometer(callback:Error->Int->Int->Int):Void;

	public function EventNameAccelerometer(callback:Void->Void):Void;
	public function unEventNameAccelerometer(callback:Void->Void):Void;

	public function subscribeAccelerometer(callback:Void->Void):Void;


	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#magnetometer
	// Read or write the period. Support values are: 1, 2, 5, 10, 20, 80, 160, or 640 ms.
	public function readMagnetometerPeriod(callback:Error->Int):Void;
	public function writeMagnetometerPeriod(period:EitherType<Int,Period>, callback:Void->Void):Void;
	// x, y, and z values
	@:overload(function (callback:Error->Int):Void {})
	public function subscribeMagnetometer(callback:Void->Void):Void;
	public function unsubscribeMagnetometer(callback:Error->Int):Void;

	// bearing
	public function subscribeMagnetometerBearing(callback:Void->Void):Void;
	public function unsubscribeMagnetometerBearing(callback:Void->Int):Void;

	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#temperature
	public function readTemperaturePeriod(callback:Void->Void):Void;
	// period is in ms.
	public function writeTemperaturePeriod(period:Int, callback:Void->Void):Void;
	public function readTemperature(callback: Error->Float):Void;
	public function subscribeTemperature(callback:Void->Void):Void;
	public function unsubscribeTemperature(callback:Error->Int):Void;


	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#pin-io
	// pin must be between 0 and 20.
	// value must be between 0 and 255.

	// AD mode (Analog/Digital mode)
	public function pinAnalog(pin:EitherType<Int,PinValue>, ?callback:Void->Void):Void;
	public function pinDigital(pin:EitherType<Int,PinValue>, ?callback:Void->Void):Void;
	// IO mode (Input/Output mode)
	public function pinInput(pin:EitherType<Int,PinValue>, ?callback:Void->Void):Void;
	public function pinOutput(pin:EitherType<Int,PinValue>, ?callback:Void->Void):Void;
	// Read or write
	// https://www.microbit.co.uk/functions/digital-read-pin
	// @:overload(function (pin:PinValue, callback:Error->FixValue->Void):Void {}) // pin must be configured as input
	public function readPin(pin:EitherType<Int,PinValue>, callback:Error->Int->Void):Void; // pin must be configured as input
	//https://www.microbit.co.uk/functions/digital-write-pin
	// @:overload(function (pin:EitherType<Int,PinValue>, value:FixValue, callback:Void->Void):Void{}) // pin must be configured as output
	public function writePin(pin:EitherType<Int,PinValue>, value:EitherType<Int,FixValue>, ?callback:Void->Void):Void; // pin must be configured as output

	// Subscription
	public function subscribePinData(callback:Void->Void):Void;
	public function unsubscribePinData(callback:Void->Void):Void;

	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#advanced
/**
 *
 *  // data is a Buffer with format: <pin> <value>, ...
microbit.readPinData(callback(error, data));

microbit.writePinData(data, callback(error));

// value is a buffer, n-bit of 0 means pin n is in digital mode, 1 means analog mode
microbit.readPinAdConfiguration(callback(error, value));

microbit.writePinAdConfiguration(value, callback(error));

// value is a buffer, n-bit of 0 means pin n  is in output mode, 1 means input mode
microbit.readPinIoConfiguration(callback(error, value));

microbit.writePinIoConfiguration(value, callback(error));
 */

}
