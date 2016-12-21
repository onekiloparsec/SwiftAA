import UIKit

public struct PlanetPosition {
    public let name: String
    public let x: CGFloat
    public let y: CGFloat
    public let color: UIColor
    
    public init(name: String, x: Double, y: Double, color: UIColor) {
        self.name = name
        self.x = CGFloat(x)
        self.y = CGFloat(y)
        self.color = color
    }
}

public class PlanetView : UIView {
    
    let circleView: UIView = {
        let view = UIView(frame: CGRect.zero)
//        view.wantsLayer = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 25.0
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
//        label.drawsBackground = false
//        label.editable = false
//        label.bezeled = false
//        label.bezelStyle = .SquareBezel
        label.backgroundColor = UIColor.clear
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .center
        return label
    }()
    
    public init(name: String, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.nameLabel.text = name
        self.circleView.backgroundColor = color
        self.addSubview(self.circleView)
        self.addSubview(self.nameLabel)

        self.circleView.frame = CGRect(x: bounds.midX - 25.0, y: 35.0, width: 50.0, height: 50.0)
        self.nameLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 35)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hideLabel(flag: Bool) {
        self.nameLabel.isHidden = flag;
    }
}

public class SolarSystemView : UIView {
    public var planetPositions: [String: CGPoint]
    public var planetColors: [String: UIColor]

    public init() {
        self.planetPositions = [:]
        self.planetColors = [:]
        super.init(frame: CGRect(x: 0, y: 0, width: 680, height: 420))
        self.backgroundColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func drawPlanet(name: String, withColor color: UIColor, atPosition pos: CGPoint) {
        let viewCenter = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.planetPositions[name] = CGPoint(x: viewCenter.x+pos.x, y: viewCenter.y+pos.y)
        self.planetColors[name] = color
        self.setNeedsDisplay()
    }
    
    override public func draw(_ dirtyRect: CGRect) {
        let viewCenter = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        let sunRadius: CGFloat = 3.0
        UIColor.yellow.setFill()

        UIBezierPath(ovalIn: CGRect(x: viewCenter.x-sunRadius, y: viewCenter.y-sunRadius, width: 2*sunRadius, height: 2*sunRadius)).fill()
        
        super.draw(dirtyRect);
        
        let radius: CGFloat = 1.0

        for key in self.planetPositions.keys {
            self.planetColors[key]!.setFill()
            let pos = self.planetPositions[key]!
            UIBezierPath(ovalIn: CGRect(x: pos.x-radius, y: pos.y-radius, width: 2*radius, height: 2*radius)).fill()
        }        
    }
}

// Usage: 
//let scale = 100.0 // pixels/AU
//
//var solarSystemView = SolarSystemView()
//XCPlaygroundPage.currentPage.liveView = solarSystemView
//
//for i in 0..<100 {
//    let jd = KPCAADate(year: 2016, month: 6, day: 21.0, usingGregorianCalendar: true).Julian() + Double(i)
//    
//    let planets: Array<Planet> = [Mars(julianDay: jd)]
//    let name = String(planets[0].dynamicType)
//    print("\(name)")
//    
//    for (index, planet) in planets.enumerate() {
//        var r = planet.radiusVector
//        var phi = planet.eclipticLongitude
//        var x = r * cos(phi.Radians)
//        var y = r * sin(phi.Radians)
//        
//        solarSystemView.drawPlanet(planet.name, withColor:planet.dynamicType.color, atPosition: CGPoint(x: x*scale, y: y*scale));
//        
//        //        if (index == 0) {
//        //            Swift.print("\(KPCAADate()) \(jd) \(x) \(y) \(r)")
//        //        }
//        
//    }
//}
//
