//
//  WeSplit2.0.swift
//  ViewsAndModifiers
//
//  Created by 范三球 on 2022/3/14.
//  使用三元运算符调整All Expenses Paid输出文字的颜色
//

import SwiftUI

struct WeSplit2_0: View {
    @State private var checkAmount = 0.0
        @State private var numberOfPeople = 2
        @State private var tipPercentage = 20
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
                            .foregroundColor(tipPercentage == 0 ? .red : .black)
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

struct WeSplit2_0_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit2_0()
    }
}
