//
//  ContentView.swift
//  WeSplit
//
//  Created by 范三球 on 2022/2/28.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
//    @State private var checkAmountAll = 0.0
//    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var checkAmountAll: Double{
        let tipAcount = checkAmount / 100 * Double(tipPercentage)
        let amountAll = checkAmount + tipAcount
        return amountAll
    }
    
//    var currentAddress: String{
//        return FloatingPointFormatStyle.Currency(code: Locale.current.currencyCode ?? "USD")
//    }
    
    @FocusState private var amountIsFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .focused($amountIsFocused)
                            .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                Section{
                    Text("\(checkAmountAll)")
                } header: {
                    Text("All expenses paid")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
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
