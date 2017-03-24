package examples;

import js.Node.console;
import js.Node.process;
import js.node.Buffer;

class LedPatternHx {

	public function new () {
		var buffer = new Buffer(new Pattern().createLedMatrixBuffer(Pattern.HEART));
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