package examples;

import js.Node.console;
import js.Node.process;

class AccelerometerListener {

	var period = 160; // ms

	public function new () {
		console.log('Scanning for microbit');
		BBCMicrobit.discover(function(microbit) {
			console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);

			microbit.on('disconnect', function() {
				console.log('\tmicrobit disconnected!');
				process.exit(0);
			});

			microbit.on('accelerometerChange', function(x, y, z) {
				console.log('\ton -> accelerometer change: accelerometer = %d %d %d G', untyped x.toFixed(1), untyped y.toFixed(1), untyped z.toFixed(1));
			});

			console.log('connecting to microbit');
			microbit.connectAndSetUp(function() {
				console.log('\tconnected to microbit');

				console.log('setting accelerometer period to %d ms', period);
				microbit.writeAccelerometerPeriod(period, function(eror) {
					console.log('\taccelerometer period set');

					console.log('subscribing to accelerometer');
					microbit.subscribeAccelerometer(function() {
						console.log('\tsubscribed to accelerometer');
					});
				});
			});
		});
	}
}



