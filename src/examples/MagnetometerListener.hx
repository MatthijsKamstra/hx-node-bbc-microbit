package examples;

import js.Node;
import js.Node.console;
import js.Node.process;

class MagnetometerListener {

	var period = 160; // ms

	public function new () {

		console.log('Scanning for microbit');
		BBCMicrobit.discover(function(microbit) {
		console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);

		microbit.on('disconnect', function() {
			console.log('\tmicrobit disconnected!');
			process.exit(0);
		});

		microbit.on('magnetometerChange', function(x, y, z) {
			console.log('\ton -> magnetometer change: magnetometer = %d %d %d', untyped x.toFixed(1), untyped y.toFixed(1), untyped z.toFixed(1));
		});

		console.log('connecting to microbit');
		microbit.connectAndSetUp(function() {
			console.log('\tconnected to microbit');

			console.log('setting magnetometer period to %d ms', period);
			microbit.writeMagnetometerPeriod(period, function() {
				console.log('\tmagnetometer period set');

				console.log('subscribing to magnetometer');
				microbit.subscribeMagnetometer(function() {
					console.log('\tsubscribed to magnetometer');
				});
			});
		});
		});
	}
}