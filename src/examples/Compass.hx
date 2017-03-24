package examples;

import js.Node.console;
import js.Node.process;

class Compass {

	var period = 160; // ms
	var last_compass_point_name = "";

	var COMPASS_POINT_DELTA = 22.5;

	var COMPASS_POINTS = [
				"N",
				"NNE",
				"NE",
				"ENE",
				"E",
				"ESE",
				"SE",
				"SSE",
				"S",
				"SSW",
				"SW",
				"WSW",
				"W",
				"WNW",
				"NW",
				"NNW"
		];

	public function new () {
		console.log('Scanning for microbit');
		BBCMicrobit.discover(function(microbit) {
			console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);

			microbit.on('disconnect', function() {
				console.log('\tmicrobit disconnected!');
				process.exit(0);
			});

			microbit.on('magnetometerBearingChange', function(bearing) {
				var point_name = compassPoint(bearing);
				if (point_name != last_compass_point_name) {
				console.log('\t Compass Direction: %s', point_name);
				last_compass_point_name = point_name;
				}
			});

			console.log('connecting to microbit');
			microbit.connectAndSetUp(function() {
				console.log('\tconnected to microbit');

				console.log('setting magnetometer period to %d ms', period);
				microbit.writeMagnetometerPeriod(period, function() {
					console.log('\tmagnetometer period set');

					console.log('subscribing to magnetometer bearing');
					microbit.subscribeMagnetometerBearing(function() {
						console.log('\tsubscribed to magnetometer bearing');
					});
				});
			});
		});
	}

	function compassPoint(bearing):String {
		var d = bearing / COMPASS_POINT_DELTA;
		var name_inx = Math.floor(d);
		if (d - name_inx > 0.5) {
			name_inx++;
		}
		if (name_inx > 15) {
			name_inx = 0;
		}
		return COMPASS_POINTS[name_inx];
	}

}