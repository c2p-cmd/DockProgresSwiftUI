//
//  ContentViewModel.swift
//  DockProgresApp
//
//  Created by Sharan Thakur on 04/02/24.
//

import Observation
import SwiftUI

@Observable
class ContentViewModel {
    /// Keeps Track of the progress on the dock
    var progress: CGFloat = 0.0 {
        didSet {
            updateLogo()
        }
    }
    
    /// Shows progress on the dock
    var isVisible = false {
        didSet {
            updateLogo()
        }
    }
    
    /// Chosen `ProgressStyle` for the dock
    var progressStyle: ProgressStyle = .flatLine {
        didSet {
            updateLogo()
        }
    }
    
    /// The `Color` to fill `progress` in
    var tint: Color = .accentColor {
        didSet {
            updateLogo()
        }
    }
    
    /// Opacity for the control group based on `isVisible`
    var opacity: CGFloat {
        isVisible ? 1.0 : 0.75
    }
    
    private func updateLogo() {
        let application: NSApplication = .shared
        
        if isVisible == false {
            application.dockTile.contentView = nil
            application.dockTile.display()
            return
        }
        
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
    }
}
