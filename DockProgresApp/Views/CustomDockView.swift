//
//  CustomDockView.swift
//  DockProgresApp
//
//  Created by Sharan Thakur on 04/02/24.
//

import SwiftUI

/// Custom Dock View to show
/// - Parameter logo: `NSImage` to display
/// - Parameter progress: The progress of task to show
/// - Parameter type: `ProgressStyle` to display in
/// - Parameter tint: `Color` to display the `progress` in
/// - Returns: A `SwiftUI View`
struct CustomDockView: View {
    var logo: NSImage
    var progress: CGFloat
    var type: ProgressStyle
    var tint: Color
    
    var body: some View {
        ZStack {
            Image(nsImage: logo)
                .scaledToFit()
            
            GeometryReader { proxy in
                let width = proxy.size.width
                let height = proxy.size.height
                
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
