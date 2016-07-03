//: Solay System Playground : a pretty cool concept!

import UIKit
import SwiftAA
import XCPlayground

let scale = 100.0 // pixels/AU

var solarSystemView = SolarSystemView()
XCPlaygroundPage.currentPage.liveView = solarSystemView

for i in 0..<100 {
    let jd = KPCAADate(year: 2016, month: 6, day: 21.0, usingGregorianCalendar: true).Julian() + Double(i)
    
    let planets: Array<Planet> = [Mars(julianDay: jd)]
    let name = String(planets[0].dynamicType)
    print("\(name)")

    for (index, planet) in planets.enumerate() {
        var r = planet.radiusVector
        var phi = planet.eclipticLongitude
        var x = r * cos(phi.Radians)
        var y = r * sin(phi.Radians)
        
            solarSystemView.drawPlanet(planet.name, withColor:planet.dynamicType.color, atPosition: CGPoint(x: x*scale, y: y*scale));
        
//        if (index == 0) {
//            Swift.print("\(KPCAADate()) \(jd) \(x) \(y) \(r)")
//        }
        
    }
}

