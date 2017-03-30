package examples;

import base.BaseMicrobit;
import base.IMicrobit;

class Servo extends BaseMicrobit implements IMicrobit {

	public function new () {
		super('test');
	}

	override public function onStart():Void{
		trace('servo onStart');

		microbit.writeLedText('test');
	}



}