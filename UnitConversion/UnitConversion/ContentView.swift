//
//  ContentView.swift
//  UnitConversion
//
//  Created by Josh Hrach on 12/30/19.
//  Copyright © 2019 Random Projects, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var warpSpeed = ""
    
    let scales = ["C", "TOS", "TNG", "JJVerse"]
    @State private var warpScale = 0
    @State private var targetWarpScale = 0
    
    var convertedWarpSpeed: Double {
        let inputSpeed = Double(warpSpeed) ?? 0
        
        // Do some kind of conversion
        return inputSpeed * 9 // Dummy for now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert This")) {
                    TextField("Warp Speed", text: $warpSpeed)
                        .keyboardType(.decimalPad)
                    
                    Picker("Scale", selection: $warpScale) {
                        ForEach(0..<scales.count) {
                            Text("\(self.scales[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To This")) {
                    Picker("Scale", selection: $targetWarpScale) {
                        ForEach(0..<scales.count) {
                            Text("\(self.scales[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Speed (in \(scales[targetWarpScale]))")) {
                    Text("\(convertedWarpSpeed)")
                }
            }.navigationBarTitle(Text("Warp Speed Conversion"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
