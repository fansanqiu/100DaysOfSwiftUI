//
//  ContentView.swift
//  Unit conversion
//
//  Created by 范三球 on 2022/2/28.
//

import SwiftUI

struct ContentView: View {
    @State private var inputLength = 0.0
    @State private var inputlengthConversion = "M"
    @State private var outputlengthConversion = "M"
    
    let inputLengthConversions = ["M","Km","Ft","Yd","Mi"]
    let outputLengthConversions = ["M","Km","Ft","Yd","Mi"]
    private var outputLength: Double{
        var converted = 0.0
        if inputlengthConversion != outputlengthConversion {
            // metres
            if inputlengthConversion == "M" && outputlengthConversion == "Km" {
                converted = inputLength / 1000
            } else if inputlengthConversion == "M" && outputlengthConversion == "Ft" {
                converted = inputLength * 3.281
            } else if inputlengthConversion == "M" && outputlengthConversion == "Yd" {
                converted = inputLength * 1.094
            } else if inputlengthConversion == "M" && outputlengthConversion == "Mi" {
                converted = inputLength / 1609
            }
            
            // kilometres
            if inputlengthConversion == "Km" && outputlengthConversion == "M" {
                converted = inputLength * 1000
            } else if inputlengthConversion == "Km" && outputlengthConversion == "Ft" {
                converted = inputLength * 3281
            } else if inputlengthConversion == "Km" && outputlengthConversion == "Yd" {
                converted = inputLength * 1094
            } else if inputlengthConversion == "Km" && outputlengthConversion == "Mi" {
                converted = inputLength / 1.609
            }
            
            // feet
            if inputlengthConversion == "Ft" && outputlengthConversion == "M" {
                converted = inputLength * 1000
            } else if inputlengthConversion == "Ft" && outputlengthConversion == "Km" {
                converted = inputLength * 3281
            } else if inputlengthConversion == "Ft" && outputlengthConversion == "Yd" {
                converted = inputLength * 1094
            } else if inputlengthConversion == "Ft" && outputlengthConversion == "Mi" {
                converted = inputLength / 1.609
            }
            
            // yards
            if inputlengthConversion == "Yd" && outputlengthConversion == "M" {
                converted = inputLength / 1760
            } else if inputlengthConversion == "Yd" && outputlengthConversion == "Km" {
                converted = inputLength / 1094
            } else if inputlengthConversion == "Yd" && outputlengthConversion == "Ft" {
                converted = inputLength * 3
            } else if inputlengthConversion == "Yd" && outputlengthConversion == "Mi" {
                converted = inputLength / 1760
            }
            
            // miles
            if inputlengthConversion == "Mi" && outputlengthConversion == "M" {
                converted = inputLength * 1609
            } else if inputlengthConversion == "Mi" && outputlengthConversion == "Km" {
                converted = inputLength * 1.609
            } else if inputlengthConversion == "Mi" && outputlengthConversion == "Ft" {
                converted = inputLength * 5280
            } else if inputlengthConversion == "Mi" && outputlengthConversion == "Yd" {
                converted = inputLength * 1760
            }
            
        } else {
            converted = inputLength
        }
        return converted
    }
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        Form {
            Section{
                TextField(
                    "Input the number you want to change",
                    value: $inputLength,
                    format: .number
                )
                .focused($amountIsFocused)
                .keyboardType(.decimalPad)
            } header: {
                Text("Input the number you want to change")
            }
            Section{
                Picker(
                    "Choose your lengthConversion",
                    selection: $inputlengthConversion
                ){
                    ForEach(
                        inputLengthConversions,
                        id: \.self
                    ){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Choose your input lengthConversion")
            }
            Section{
                Picker(
                    "Choose your lengthConversion",
                    selection: $outputlengthConversion
                ){
                    ForEach(
                        outputLengthConversions,
                        id: \.self
                    ){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            header: {
                Text("Choose your output lengthConversion")
            }
            Section{
               Text(
                "\(outputLength.formatted())"
               )
            }
            header: {
                Text("This is the final number")
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Spacer()

                Button("Done"){
                    amountIsFocused = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
