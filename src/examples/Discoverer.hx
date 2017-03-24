package examples;

import js.Node.console;

/**
 * @author Matthijs Kamstra aka [mck]
 */
class Discoverer {

	public function new () {

		// Found a microbit: id = f4795fe7854c449293d468a4b54273de, address = d0:3f:be:bd:3a:50
		var id = "f4795fe7854c449293d468a4b54273de";
		var address = "d0:3f:be:bd:3a:50";

		// scan for all microbits
		console.log('Scanning for microbits');

		/*
		// discover all microbits
		BBCMicrobit.discoverAll(function(microbit) {
			console.log('\tFound a microbit: id = %s, address = %s', microbit.id, microbit.address);
		});
		*/

		/*
		// to scan for a particular id use:
		BBCMicrobit.discoverById(id, function(microbit) {
			console.log('\tFound a microbit by id: id = %s, address = %s', microbit.id, microbit.address);
		});
		*/

		/*
		// to scan for a particular address use:
		BBCMicrobit.discoverByAddress(address, function(microbit) {
			console.log('\tFound a microbit by address id = %s, address = %s', microbit.id, microbit.address);
		});
		*/


		function onDiscover(microbit) {
			console.log('\tFound a microbit: id = %s, address = %s', microbit.id, microbit.address);
		}

		BBCMicrobit.discoverAll(onDiscover);
		// BBCMicrobit.stopDiscoverAll(onDiscover);


	}

}
