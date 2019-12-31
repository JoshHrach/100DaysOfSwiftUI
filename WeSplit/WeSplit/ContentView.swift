//
//  ContentView.swift
//  WeSplit
//
//  Created by Josh Hrach on 12/30/19.
//  Copyright © 2019 Random Projects, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let total = checkTotal + tipValue
        return total / peopleCount
    }
    
    var checkTotal: Double {
        Double(checkAmount) ?? 0
    }
    
    var tipValue: Double {
        let tipSelect = Double(tipPercentages[tipPercentage])
        return checkTotal * (tipSelect / 100)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Tip Percentage")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total Bill (with $\(tipValue, specifier: "%.2f") tip)")) {
                    Text("$\(checkTotal + tipValue, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
