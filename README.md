 [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/onekiloparsec/SwiftAA)

# SwiftAA
*Bringing the best implementation of the Astronomical Algorithms to Apple's Swift realm.*

Using AA+ version 1.63 (released 16 September 2015)

Licence
=======

The licence of this software is the [MIT](http://opensource.org/licenses/MIT) licence. But it does not apply to the AA+ Framework,
which retains its own licence. Quoting the [original](http://www.naughter.com/aa.html):

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

Notes and Conventions
=====================

Needless to say how different the syntax is between C, C++, Objective-C and Swift. The main guideline in writting SwiftAA
is to build a Swift-compatible C/Objective-C layer that follow *strictly* the methods and interfaces of the underlying
C++ library. A more object-oriented library, built around SwiftAA and containing some additional utilities, 
is being written [elsewhere](https://github.com/onekiloparsec/AstroCocoaKit).

As Objective-C lacks namespaces, everything must be prefixed. It is a convention to use 3-letters prefixes in
Objective-C. KPC stands for "kiloparsec"... and is "my" usual prefix. I chose to keep the AA prefix that belongs to the C++
library as well. Hence the (rather long) 5-letters *KPCAA* prefix of all methods and class names.

These naming constraints come from the fact that no C++ code can be written directly alongside Swift code (in the same file). 
And Swift doesn't have the header/implementation split into different files. Hence one must write a Objective-C++/C wrapper
around it, with name prefixes.

One could argue in favor of another pure-Swift layer, to hide these naming constraints, and use more of the Swift power and
type safety. However, it would imply to maintain 2 layers instead of 1. Given the size of the concerned public... I would
prefer to concentrate efforts on the aformentionned Swift library built atop SwiftAA rather than this extra layer.

The first version of SwiftAA (tags 1.0+) was written with NSObject class methods, which is probably no more efficient that pure C-functions. 
It just happened that I wrote this with objects. However, it *is* totally inefficient to allocate thousands of coordinates instances one might need
for plotting/storing some curves. Hence, I decided to remove KPCAA2DCoordinates and KPCAA3DCoordinates classes, and move from Objective-C
class methods to pure C-functions wrappers, in most cases. The most notable exception is KPCAADate which remains an NSObject subclass.

Upon completion, this new version will be tagged 2.0+. It will contain the AA+ v1.63 (with the new 
[VSOP](https://en.wikipedia.org/wiki/VSOP_(planets)) implementation!). The tagged versions 1.0+ will remain as such, 
with AA+ v1.60.