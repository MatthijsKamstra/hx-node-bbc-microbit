# hx-node-bbc-microbit

![](icon.jpg)

Control a BBC micro:bit from Node.js using BLE and [Haxe](http://haxe.org/)

This are the Haxe node.js externs from <https://github.com/sandeepmistry/node-bbc-microbit>

![](img/microbit.png)

## Haxe?

Read more about [Haxe](README_HAXE.MD)


## Installation Haxe/NPM

#### 1. [follow instructions to install `bbc-microbit`](https://github.com/sandeepmistry/node-bbc-microbit#prerequisites)
> Make sure to follow the instructions for `noble` too.

#### 2. install dependencies with npm
```
npm install
```

#### 3. install haxelib

```
haxelib git bbc-microbit https://github.com/MatthijsKamstra/hx-node-bbc-microbit
```



## Haxelib

use this repo locally

```
haxelib dev bbc-microbit path/to/folder/src
```

or this git repo

```
haxelib git bbc-microbit https://github.com/MatthijsKamstra/hx-node-bbc-microbit
```

don't forget to add it to your build file

```
-lib hxmeteor
```


## Haxe niceties

create a (LED)pattern from an array

```haxe
var X = [
	1, 0, 0, 0, 1,
	0, 1, 0, 1, 0,
	0, 0, 1, 0, 0,
	0, 1, 0, 1, 0,
	1, 0, 0, 0, 1,
];
var buffer = new Buffer(new Pattern().createLedMatrixBuffer(Pattern.HEART));

// follow example "LedPatternHx"

```

Use string to listen to or `EventName`

```haxe
import BBCMicrobit;

microbit.on('buttonAChange', function(value) {
	console.log('\ton -> button A change');
});
microbit.on(EventName.BUTTON_A_CHANGE, function(value) {
	console.log('\ton -> button A change');
});
```

Use the fixed values for AccelerometerPeriod `Period`

```haxe
import BBCMicrobit;

microbit.writeAccelerometerPeriod(Period.NR_160, function(eror) {
	console.log('\taccelerometer period set');
});
```


## Examples

most examples from <https://github.com/sandeepmistry/node-bbc-microbit> are "redone" in Haxe

- AccelerometerListener.hx
- ButtonListener.hx
- Compass.hx
- Discoverer.hx
- EventListener.hx
- LedPattern.hx
- LedPatternHx.hx
- LedPatternTest.hx
- LedText.hx
- // MagnetometerBearingListener.hx
- // MagnetometerListener.hx
- PinBlink.hx
- PinListener.hx
- TemperatureListener.hx

## Blink

![](img/pins.png)


## Source

- <https://microbit-playground.co.uk/howto/microbit-blink-led-example>
- <http://www.microbitlearning.com/page/5>
- <http://www.makerspace-uk.co.uk/a-selection-of-microbit-projects/>
- <https://learn.adafruit.com/adafruit-arduino-lesson-2-leds/resistors>
- <https://www.kitronik.co.uk/blog/bbc-microbit-kitronik-university/>