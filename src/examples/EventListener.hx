package examples;

import js.Node.console;
import js.Node.process;

class EventListener {

	var EVENT_FAMILY    = 9999;
	var EVENT_VALUE_ANY = 0;
	var EVENT_VALUE_1   = 1;

	public function new () {
		console.log('Scanning for microbit');
		BBCMicrobit.discover(function(microbit) {
			console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);


			microbit.on('event', function(id, value) {
				console.log('\ton -> micro:bit event received event: %d value: %d', id, value);
			});

			microbit.on('disconnect', function() {
				console.log('\tmicrobit disconnected!');
				process.exit(0);
			});

			console.log('connecting to microbit');
			microbit.connectAndSetUp(function() {
				console.log('\tconnected to microbit');

				// Example 1: subscribe to all micro:bit events with ID 9999 and any event value
				console.log('subscribing to event family 9999, any event value');
				microbit.subscribeEvents(EVENT_FAMILY, EVENT_VALUE_ANY, function(error) {
					console.log('\tsubscribed to micro:bit events of required type');
				});

				// Example 2: subscribe to the specific event with ID=9999 and value=0001 only
			//    console.log('subscribing to event family 9999, event value 0001');
			//    microbit.subscribeEvents(EVENT_FAMILY, EVENT_VALUE_1, function() {
			//      console.log('\tsubscribed to micro:bit events of required type');
			//    });
			});
		});
	}
}