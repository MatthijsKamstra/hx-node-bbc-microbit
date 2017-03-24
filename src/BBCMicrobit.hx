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

/**
 *  https://github.com/sandeepmistry/node-bbc-microbit
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
	public function subscribeEvents(id:Int, value:Int, callback:Void->Void):Dynamic;


	// led-service
	// https://github.com/sandeepmistry/node-bbc-microbit/blob/master/API.md#led-matrix
	public function readLedMatrixState(callback:Void->Void):Void;
	public function writeLedMatrixState(data:Buffer, callback:Void->Void):Void;
	// text is a string that must be 20 characters or less
	public function writeLedText(text:String, callback:Void->Void):Void;
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
	public function subscribeMagnetometer(callback:Error->Int):Void;
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

	// AD mode
	public function pinAnalog(pin:Int, callback:Void->Void):Void;
	public function pinDigital(pin:Int, callback:Void->Void):Void;
	// IO mode
	public function pinInput(pin:Int, callback:Void->Void):Void;
	public function pinOutput(pin:Int, callback:Void->Void):Void;
	//Read or write
	public function readPin(pin:Int, callback:Error->Int->Void):Void; // pin must be configured as input
	public function writePin(pin:Int, value:Int, callback:Void->Void):Void; // pin must be configured as output
	// Subscription
	public function subscribePinData(callback:Void->Void):Void;
	public function unsubscribePinData(callback:Void->Void):Void;

}
