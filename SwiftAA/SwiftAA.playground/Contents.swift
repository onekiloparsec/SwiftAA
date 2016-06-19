//: Playground - noun: a place where people can play

import Cocoa
import SwiftAA

var str = "Hello, playground"

struct PlanetPosition {
    let name: String
    let x: CGFloat
    let y: CGFloat
    let color: NSColor
    
    init(name: String, x: Double, y: Double, color: NSColor) {
        self.name = name
        self.x = CGFloat(x)
        self.y = CGFloat(y)
        self.color = color
    }
}

class SolarSystemView : NSView {
    var planetPositions: Array<PlanetPosition>? {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override init(frame: NSRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func drawPlanets(planets: Array<PlanetPosition>) {
        self.planetPositions = planets
    }
    
    override func drawRect(dirtyRect: NSRect) {
        NSColor.blackColor()
        NSRectFill(self.bounds)
        let viewCenter = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        let sunRadius: CGFloat = 3.0
        NSColor.yellowColor().setFill()
        NSBezierPath(ovalInRect: CGRectMake(viewCenter.x-sunRadius, viewCenter.y-sunRadius, 2*sunRadius, 2*sunRadius)).fill()

        if self.planetPositions?.count > 0 {
            let color = NSColor(calibratedRed: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
            color.setFill()

            for p in self.planetPositions! {
                let radius: CGFloat = 1.0
                let x = viewCenter.x + p.x
                let y = viewCenter.y + p.y
                
                NSBezierPath(ovalInRect: CGRectMake(x-radius, y-radius, 2*radius, 2*radius)).fill()
            }
        }
    }
}

let scale = 30.0 // 10 pixels / A
let mercuryColor = NSColor(calibratedRed: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)

var view = SolarSystemView(frame: NSRect(x: 0, y: 0, width: 600, height: 600))


for i in 0..<1000 {
    let jd = KPCAADate().Julian() + Double(i)
    
    var planetPositions: Array<PlanetPosition> = []
    let planets: Array<EclipticObject> = [Mercury(julianDay: jd),
                                          Venus(julianDay: jd),
                                          Earth(julianDay: jd),
                                          Mars(julianDay: jd),
                                          Jupiter(julianDay: jd),
                                          Saturn(julianDay: jd),
                                          Neptune(julianDay: jd),
                                          Pluto(julianDay: jd)]

    for planet: EclipticObject in planets {
        var r = planet.radiusVector()
        var phi = planet.eclipticLongitude()
        var x = r * cos(phi.Radians)
        var y = r * sin(phi.Radians)
        planetPositions.append(PlanetPosition(name: planet.name(), x: x*scale, y: y*scale, color: mercuryColor))
    }

    view.planetPositions = planetPositions
}


