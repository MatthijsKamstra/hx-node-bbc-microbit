package examples;

import js.Node.console;
import js.Node.process;
import js.node.Buffer;

import haxe.Timer;

import BBCMicrobit;

class LedPatternHx {

	var microbit:MicrobitObj;

	public function new () {
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
					trace('model number: ' + value);
				});

				microbit.readSerialNumber(function(error, value){
					trace('serial number: ' + value);
				});

				microbit.readFirmwareRevision(function(error, value){
					trace('firmware revision number: ' + value);
				});

				console.log('sending pattern: "%s"', buffer.toString('hex'));
				microbit.writeLedMatrixState(buffer, function() {
					console.log('\tpattern sent');

					// console.log('disconnecting');
					// microbit.disconnect();
				});

				// untyped setTimeout(setFullColor, 5000);

				Timer.delay(setFullColor, 5000);

			});
		});
	}

	function setFullColor(){
      console.log('writeLedMatrixState');
      microbit.writeLedMatrixState(new Buffer('1f1f1f1f1f', 'hex'), function(){
		microbit.readLedMatrixState(function(error, data) {
        	console.log('\t LED matrix state = %s', data.toString('hex'));
			// untyped setTimeout(setNoColor, 5000);
			Timer.delay(setNoColor, 5000);
		});
	  });
	}
	function setNoColor(){
      console.log('writeLedMatrixState');
      microbit.writeLedMatrixState(new Buffer('0000000000', 'hex'), function(){
		microbit.readLedMatrixState(function(error, data) {
        	console.log('\t LED matrix state = %s', data.toString('hex'));
			// untyped setTimeout(setNoColor, 500);
		});
	  });
	}
}