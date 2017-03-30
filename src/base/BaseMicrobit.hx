package base;

import base.IMicrobit;
import js.Node.console;
import js.Node.process;
import js.node.Buffer;

import haxe.Timer;

import BBCMicrobit;

class BaseMicrobit implements IMicrobit {

	var str : String;
	var delay : Int;

	public var microbit:MicrobitObj;

	public function new (?str:String,?delay:Int = 1000) {
		this.str = str;
		this.delay = delay;

		onInit();
	}

	public function onInit():Void{
		var buffer = new Buffer(new Pattern().createLedMatrixBuffer(Pattern.HEART));
		console.log('Scanning for microbit');
		BBCMicrobit.discover(function(microbit) {
			console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);

			this.microbit = microbit;

			microbit.on('disconnect', function() {
				console.log('\tmicrobit disconnected!');
				process.exit(0);
			});

			console.log('connecting to microbit');
			microbit.connectAndSetUp(function() {
				console.log('\tconnected to microbit');

				microbit.readModelNumber(function(error, value){
					console.log('model number: ' + value);
				});

				microbit.readSerialNumber(function(error, value){
					console.log('serial number: ' + value);
				});

				microbit.readFirmwareRevision(function(error, value){
					console.log('firmware revision number: ' + value);
				});

				microbit.readDeviceName(function(error, value){
					console.log('device name: ' + value);
				});

				console.log('sending pattern: "%s"', buffer.toString('hex'));
				microbit.writeLedMatrixState(buffer, function() {
					console.log('\tpattern sent');

					haxe.Timer.delay(onStart, delay);
					// onStart();
				});

			});
		});
	}

	public function onStart():Void{
		trace('override function onStart');
	}

}