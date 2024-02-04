# Dock Progress SwiftUI

## A simple demo of showing a progress of possibly anything on the dock of your macOS app!

## Code:
### We create our `CustomDockView`:
- **logo**: `NSImage` to display
- **progress**: The progress of task to show
- **type**: `ProgressStyle` to display in
- **tint**: `Color` to display the `progress` in
```swift
struct CustomDockView: View {
    var logo: NSImage
    var progress: CGFloat
    var type: ProgressStyle
    var tint: Color
    
    var body: some View {
        ZStack {
            Image(nsImage: logo)
                .scaledToFit()
            
            GeometryReader {
                let width = $0.size.width
                
                // Limits progress between 0 & 1
                let cappedProgress = max(min(progress, 1), 0)
                
                switch type {
                case .rounded:
                    RoundedRectangle(cornerRadius: width * 0.225)
                        .trim(from: 0, to: cappedProgress)
                        .stroke(tint, lineWidth: 6)
                        .rotationEffect(.degrees(-90))
                case .flatLine:
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(.primary.opacity(0.5))
                        
                        Capsule()
                            .fill(tint)
                            .frame(width: width * cappedProgress)
                    }
                    .frame(height: 8)
                    .frame(maxWidth: .infinity, alignment: .bottom)
                }
            }
            .padding(15)
        }
    }
}
```
### Business Logic to update the dock with paramters:
```swift
let application: NSApplication = .shared

if isVisible == false {
    application.dockTile.contentView = nil
    application.dockTile.display()
    return
}

// fetches current logo `NSImage`
guard let logo = application.applicationIconImage else {
    return
}

// Custom Dock View
let customView = NSHostingView(
    rootView: CustomDockView(
        logo: logo,
        progress: progress,
        type: progressStyle,
        tint: tint
    )
)
customView.layer?.backgroundColor = .clear
customView.frame.size = logo.size

// Adding to the dock
application.dockTile.contentView = customView
// Refresh the dock
application.dockTile.display()
```
