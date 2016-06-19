//: Playground - noun: a place where people can play

import Cocoa
import SwiftAA
import XCPlayground

let scale = 30.0 // pixels/AU

let mercury = Mercury(julianDay: KPCAADate().Julian())
let planetView = View(name: "Mercury", color: mercury.color)

var solarSystemView = SolarSystemView()
XCPlaygroundPage.currentPage.liveView = solarSystemView

//for i in 0..<1000 {
//    let jd = KPCAADate().Julian() + Double(i)
//    
//    var planetPositions: Array<PlanetPosition> = []
//    let planets: Array<EclipticObject> = [Mercury(julianDay: jd),
//                                          Venus(julianDay: jd),
//                                          Earth(julianDay: jd),
//                                          Mars(julianDay: jd),
//                                          Jupiter(julianDay: jd),
//                                          Saturn(julianDay: jd),
//                                          Neptune(julianDay: jd),
//                                          Pluto(julianDay: jd)]
//
//    for planet: EclipticObject in planets {
//        var r = planet.radiusVector()
//        var phi = planet.eclipticLongitude()
//        var x = r * cos(phi.Radians)
//        var y = r * sin(phi.Radians)
//        planetPositions.append(PlanetPosition(name: planet.name(), x: x*scale, y: y*scale, color: mercuryColor))
//    }
//
//    solarSystenView.planetPositions = planetPositions
//}
//
//
