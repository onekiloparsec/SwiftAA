import Cocoa

public struct PlanetPosition {
    public let name: String
    public let x: CGFloat
    public let y: CGFloat
    public let color: NSColor
    
    public init(name: String, x: Double, y: Double, color: NSColor) {
        self.name = name
        self.x = CGFloat(x)
        self.y = CGFloat(y)
        self.color = color
    }
}

public class View : NSView {
    
    let planetView: NSView = {
        let view = NSView(frame: NSZeroRect)
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.whiteColor().CGColor
        view.layer?.borderWidth = 2.0
        view.layer?.cornerRadius = 25.0
        return view
    }()
    
    let nameLabel: NSTextField = {
        let label = NSTextField()
        label.drawsBackground = false
        label.editable = false
        label.bezeled = false
        label.bezelStyle = .SquareBezel
        label.backgroundColor = NSColor.clearColor()
        label.font = NSFont.boldSystemFontOfSize(10.0)
        label.alignment = .Center
        return label
    }()
    
    public init(name: String, color: NSColor) {
        super.init(frame: NSMakeRect(0, 0, 250, 100))
        self.nameLabel.stringValue = name
        self.planetView.layer?.backgroundColor = color.CGColor
        self.addSubview(self.planetView)
        self.addSubview(self.nameLabel)
        self.planetView.frame = NSMakeRect(bounds.midX - 25.0, 35.0, 50.0, 50.0)
        self.nameLabel.frame = NSMakeRect(0, 0, bounds.width, 35)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}

public class SolarSystemView : NSView {
    public var planetPositions: Array<PlanetPosition>? {
        didSet {
            self.needsDisplay = true
        }
    }

    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 680, height: 420))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawPlanets(planets: Array<PlanetPosition>) {
        self.planetPositions = planets
    }
    
    override public func drawRect(dirtyRect: CGRect) {
        let viewCenter = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        NSColor.blackColor().setFill()
        NSRectFill(self.bounds)
        
        let sunRadius: CGFloat = 3.0
        NSColor.yellowColor().setFill()
        NSBezierPath(ovalInRect: CGRectMake(viewCenter.x-sunRadius, viewCenter.y-sunRadius, 2*sunRadius, 2*sunRadius)).fill()
        
        if self.planetPositions?.count > 0 {
            let color = NSColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
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
