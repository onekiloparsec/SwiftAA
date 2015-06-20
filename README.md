# SwiftAA
*Bringing the best implementation of the Astronomical Algorithms to Apple's Swift realm.*

Licence
=======

The licence of this software is the [MIT](http://opensource.org/licenses/MIT) licence. But it does not apply to the AA+ Framework, which retains its own licence. Quoting the [original](http://www.naughter.com/aa.html):

**AA+ Copyright :** 

* You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) when your product is released in binary form.
* You are allowed to modify the source code in any way you want except you cannot modify the copyright details at the top of each module.
* If you want to distribute source code with your application, then you are only allowed to distribute versions released by the author. This is to maintain a single distribution point for the source code.

Introduction
============

The AA+ framework, written in C++ by PJ Naughter (Visual C++ MVP) is certainly the best and most complete implementation of the
"Astronomical Algorithms", by Jean Meeus (purchasable from [Amazon](http://www.amazon.com/exec/obidos/tg/detail/-/0943396611/103-5742735-0567011)).
To make the most of this code, you'd rather have a copy of the book with you.

As the author of the app iObserve (for [Mac](http://onekilopars.ec/apps#iobserve) and [iPad](http://www.onekilopars.ec/apps/#iobserve-touch)), I have
myself worked a lot on implementing some of the AA algorithms for my needs. However, to push iObserve to the next level,
I need to put a lot more work on these algorithms. And it is pointless (as well as very hard) to reach the fantastic level and quality the AA+ framework
has already reached, after years of development and tests.

P.J. Naughter has kindly agreed to let me create a public repo with his code. My intention is to write a wrapper around it,
to bring the AA+ framework to Apple's Swift realm (and Objective-C along the way). Pull requests will be accepted (if by any chance
it happens) only about the Objective-C and Swift code. The AA+ code changes must be directed (as I will personnaly do if I need to)
to the original source (see the [AA+ website](http://www.naughter.com/aa.html)).
