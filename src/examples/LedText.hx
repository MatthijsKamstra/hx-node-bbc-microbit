package examples;

import js.Node.console;
import js.Node.process;

class LedText {

	var text = 'Hello there';

	public function new () {

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

				console.log('sending text: "%s"', text);
				microbit.writeLedText(text, function() {
					console.log('\ttext sent');

					console.log('disconnecting');
					microbit.disconnect();
				});
			});
		});

	}
}