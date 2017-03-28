package examples;

import js.Node.console;
import js.Node.process;
import js.node.Buffer;

/**
// the micro:bit 5x5 LED display can be set to any pattern by sending a 5 byte array to it. Each byte contains a value which sets the LEDs
// in a particular row to either on or off. The 5 least significant bits in each byte correspond to each of the 5 LEDs in that row:
//
//    Octet 0, LED Row 1: bit4 bit3 bit2 bit1 bit0
//    Octet 1, LED Row 2: bit4 bit3 bit2 bit1 bit0
//    Octet 2, LED Row 3: bit4 bit3 bit2 bit1 bit0
//    Octet 3, LED Row 4: bit4 bit3 bit2 bit1 bit0
//    Octet 4, LED Row 5: bit4 bit3 bit2 bit1 bit0
*/
class LedPatternTest {



	public function new () {
		//  var buffer = new Buffer('0F03050910', 'hex');
		var buffer = new Buffer(new Pattern().createLedMatrixBuffer(Pattern.HAXE));
		console.log('Scanning for microbit');
		BBCMicrobit.discover(function(microbit) {
			console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);

			microbit.on('disconnect', function() {
				console.log('\tmicrobit disconnected!');
				process.exit(0);
			});

			console.log('connecting to microbit');
			microbit.connectAndSetUp(function() {
				console.log('\tconnected to microbit');

				microbit.readModelNumber(function(error, value){
					trace('value: ' + value);
				});

				console.log('sending pattern: "%s"', buffer.toString('hex'));
				microbit.writeLedMatrixState(buffer, function() {
					console.log('\tpattern sent');

					console.log('disconnecting');
					microbit.disconnect();
				});
			});
		});

	}
}