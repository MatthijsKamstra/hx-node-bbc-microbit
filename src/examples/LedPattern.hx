package examples;

import js.Node.console;
import js.Node.process;
import js.node.Buffer;

class LedPattern {

	var PATTERNS = [
		{
			name: 'Arrow up right',
			value: new Buffer('0F03050910', 'hex')
		},
		{
			name: 'Arrow down left',
			value: new Buffer('011214181E', 'hex')
		},
		{
			name: 'Arrow down right',
			value: new Buffer('100905030F', 'hex')
		},
		{
			name: 'Arrow down left',
			value: new Buffer('011214181E', 'hex')
		},
		{
			name: 'Arrow up left',
			value: new Buffer('1E18141201', 'hex')
		},
		{
			name: 'Diamond',
			value: new Buffer('040A110A04', 'hex')
		},
		{
			name: 'Smile',
			value: new Buffer('0A0A00110E', 'hex')
		},
		{
			name: 'Wink',
			value: new Buffer('080B00110E', 'hex')
		},
		{
			name: 'Solid',
			value: new Buffer('1F1F1F1F1F', 'hex')
		},
		{
			name: 'Blank',
			value: new Buffer('0000000000', 'hex')
		}
	];


	public function new () {

		var patternIndex = Math.floor((Math.random() * PATTERNS.length)); // choose a random pattern
		var pattern = PATTERNS[patternIndex];

		// search for a micro:bit, to discover a particular micro:bit use:
		//  BBCMicrobit.discoverById(id, callback); or BBCMicrobit.discoverByAddress(id, callback);

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

				console.log('sending pattern: "%s"', pattern.name);
				microbit.writeLedMatrixState(pattern.value, function() {
					console.log('\tpattern sent');

					console.log('disconnecting');
					microbit.disconnect();
				});
			});
		});
	}
}