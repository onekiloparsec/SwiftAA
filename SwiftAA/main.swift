//
//  main.swift
//  swiftaa
//
//  Created by Cédric Foellmi on 18/07/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

// This is the command-line project for Swift AA.

import Foundation

var args = Process.arguments[1..<Process.arguments.count]
var name = args.map{ $0 }.joinWithSeparator(",")

print("Hello, \(name)!")

// Ok, once Swift3 is out, use https://github.com/kylef/Commander with https://swift.org/package-manager/#conceptual-overview