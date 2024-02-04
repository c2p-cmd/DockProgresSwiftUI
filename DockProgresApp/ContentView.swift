//
//  ContentView.swift
//  DockProgresApp
//
//  Created by Sharan Thakur on 04/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Toggle("Show Progress", isOn: $viewModel.isVisible)
                .font(.title)
            
            Group {
                Picker("Progress Style", selection: $viewModel.progressStyle) {
                    ForEach(ProgressStyle.allCases, id: \.self) {
                        Text($0.rawValue)
                            .font(.title3)
                    }
                }
                .pickerStyle(.radioGroup)
                
                ColorPicker(
                    "Color of progress",
                    selection: $viewModel.tint,
                    supportsOpacity: false
                )
            }
            .font(.title)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onReceive(timer) { t in
            if viewModel.isVisible == false {
                return
            }
            
            if viewModel.progress >= 1.0 {
                viewModel.isVisible = false
                viewModel.progress = .zero
            } else {
                let range: Range<CGFloat> = (0.004..<0.008)
                viewModel.progress += CGFloat.random(in: range)
            }
        }
    }
}


//#Preview {
//    ContentView()
//        .frame(width: 500, height: 420)
//}
