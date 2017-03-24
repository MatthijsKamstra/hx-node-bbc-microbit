package examples;

import js.Node.console;
import js.Node.process;

import BBCMicrobit;

class PinBlink {

	var pin = 0;
	var interval = 1000; // ms
	var pinValue = 0;

	var microbit:MicrobitObj;

	public function new () {

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

				console.log('setting pin %d as output', pin);
				microbit.pinOutput(pin, function() {
					console.log('\tpin set as output');

					console.log('setting pin %d as digital', pin);
					microbit.pinDigital(pin, function() {
						console.log('\tpin set as digital');
						togglePin();
					});
				});
			});
		});
	}

	function togglePin() {
		pinValue = (pinValue == 0) ? 1 : 0;
		console.log('writing %d to pin %d', pinValue, pin);
		microbit.writePin(pin, pinValue, function() {
			console.log('\tdone');
			untyped setTimeout(togglePin, interval);
		});
	}
}