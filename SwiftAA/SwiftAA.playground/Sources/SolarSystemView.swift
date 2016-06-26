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
        let view = UIView(frame: CGRectZero)
//        view.wantsLayer = true
        view.layer.borderColor = UIColor.whiteColor().CGColor
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
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.boldSystemFontOfSize(10.0)
        label.textAlignment = .Center
        return label
    }()
    
    public init(name: String, color: UIColor) {
        super.init(frame: CGRectMake(0, 0, 50, 50))
        self.nameLabel.text = name
        self.circleView.backgroundColor = color
        self.addSubview(self.circleView)
        self.addSubview(self.nameLabel)
        self.circleView.frame = CGRectMake(bounds.midX - 25.0, 35.0, 50.0, 50.0)
        self.nameLabel.frame = CGRectMake(0, 0, bounds.width, 35)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func hideLabel(flag: Bool) {
        self.nameLabel.hidden = flag;
    }
}

public class SolarSystemView : UIView {
    public var planetPositions: [String: CGPoint]
    public var planetColors: [String: UIColor]

    public init() {
        self.planetPositions = [:]
        self.planetColors = [:]
        super.init(frame: CGRect(x: 0, y: 0, width: 680, height: 420))
        self.backgroundColor = UIColor.whiteColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func drawPlanet(name: String, withColor color: UIColor, atPosition pos: CGPoint) {
        let viewCenter = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.planetPositions[name] = CGPoint(x: viewCenter.x+pos.x, y: viewCenter.y+pos.y)
        self.planetColors[name] = color
        self.setNeedsDisplay()
    }
    
    override public func drawRect(dirtyRect: CGRect) {
        let viewCenter = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        let sunRadius: CGFloat = 3.0
        UIColor.yellowColor().setFill()
        UIBezierPath(ovalInRect: CGRectMake(viewCenter.x-sunRadius, viewCenter.y-sunRadius, 2*sunRadius, 2*sunRadius)).fill()
        
        super.drawRect(dirtyRect);
        
        let radius: CGFloat = 1.0

        for key in self.planetPositions.keys {
            self.planetColors[key]!.setFill()
            let pos = self.planetPositions[key]!
            UIBezierPath(ovalInRect: CGRectMake(pos.x-radius, pos.y-radius, 2*radius, 2*radius)).fill()
        }        
    }
}
