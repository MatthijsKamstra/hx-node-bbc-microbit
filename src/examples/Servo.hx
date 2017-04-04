package examples;

import haxe.Timer;
import base.BaseMicrobit;
import base.IMicrobit;

import BBCMicrobit;

class Servo extends BaseMicrobit implements IMicrobit {

	var timer : Timer;
	var isLightOn : Bool = true;
	var isServoOn : Bool = true;

	public function new () {
		super('servo');
	}

	override public function onStart():Void{
		trace('servo onStart');

		BBCMicrobit.trace('test servo');

		// BBCMicrobit.writeAnalogPin(microbit, PinValue.P0, 300, function (){
		// 	trace('servo does something?');
		// });


		timer = new Timer(2000);
		// timer.run = toggleLED;
		timer.run = toggleServo;
	}

	function toggleLED(){
		if (isLightOn) {
			BBCMicrobit.writeDigitalPin(microbit, PinValue.P1, FixValue.IS_OFF, function (){
				trace('set LED off');
			});
		} else {
			BBCMicrobit.writeDigitalPin(microbit, PinValue.P1, FixValue.IS_ON, function (){
				trace('set LED on');
			});
		}
		isLightOn = !isLightOn;
	}
	function toggleServo(){
		if (isServoOn) {
			BBCMicrobit.writeAnalogPin(microbit, PinValue.P1, 180, function (){
				trace('set servo 200');
			});
		} else {
			BBCMicrobit.writeAnalogPin(microbit, PinValue.P1, 0, function (){
				trace('set servo 0');
			});
		}
		isServoOn = !isServoOn;
	}



}