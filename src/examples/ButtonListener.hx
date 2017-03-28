package examples;

import js.Node;
import js.Node.console;
import js.Node.process;

import BBCMicrobit;

class ButtonListener
{
	var BUTTON_VALUE_MAPPER = ['Not Pressed', 'Pressed', 'Long Press'];

	public function new()
	{
		console.log('Scanning for microbit');

		BBCMicrobit.discover(function(microbit) {
			console.log('\tdiscovered microbit: id = %s, address = %s', microbit.id, microbit.address);

			// saveFile('microbit.json', Std.string (microbit));

			// trace(microbit);

			microbit.on('disconnect', function() {
				console.log('\tmicrobit disconnected!');
				process.exit(0);
			});

			// microbit.on('buttonAChange', function(value) {
			microbit.on(EventName.BUTTON_A_CHANGE, function(value) {
				console.log('\ton -> button A change: ', BUTTON_VALUE_MAPPER[value]);
			});

			microbit.on('buttonBChange', function(value) {
				console.log('\ton -> button B change: ', BUTTON_VALUE_MAPPER[value]);
			});

			console.log('connecting to microbit');
			microbit.connectAndSetUp(function() {
				console.log('\tconnected to microbit');

				console.log('subscribing to buttons');
				// to only subscribe to one button use:
				//   microbit.subscribeButtonA();
				// or
				//   microbit.subscribeButtonB();
				microbit.subscribeButtons(function() {
					console.log('\tsubscribed to buttons');
				});
			});
		});

	}

	public static function saveFile(filename:String,str:String) {
		sys.io.File.saveContent( Node.__dirname +  '/_data/${filename}', str);
	}

}