# Skan's Radio Telemetry version 1.0.1

Author: Skandragon (http://github.com/skandragon)

A Factorio mod which transmits signals (telemetry) over long distances.

This mod includes two transmitter types and a receiver.  All signals
may be used with either transmitter, although the range of the smaller one is limited, as is its power consumption.

## How to Use It

While there are many ways to use this mod, I use it to indicate when a base needs some specific item to be delivered by train.

What I do is use an arithmetic combinator to subtract the desired quantity to keep on hand, another to multiply this by -1, and then transmit that result into the radio transmitter.  Each remote base which provides iron plate has a train with a destination of the main base, with conditions of "iron plate > 0 AND inventory full" with a radio receiver connected to the sending station.

The final combinator can be shared if you use "EACH * -1 output EACH" as well.

There is currently no support for channels. If this is desired, where multiple receivers can transmit the same signal types without interference, let me know as an issue here.

## License

Derived from work by: ItsTheKais  ( kaiseryoshi@gmail.com ) (wireless-signals)

License information:

The models used for this mod's graphics were made by BS2001. They are available for "unrestricted use" and were obtained from: http://www.sharecg.com/v/81581/browse/5/3D-Model/48-models-OBJ

Any content not outlined above is available under the GNU Lesser General Public License v3.0:

https://www.gnu.org/licenses/gpl.txt
https://www.gnu.org/licenses/lgpl-3.0.txt
