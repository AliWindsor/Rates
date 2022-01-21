//
//  ContentView.swift
//  XRate
//
//  Created by Alicia Windsor on 22/07/2021.
//

import SwiftUI

struct ContentView: View {
    //@State public var ratesKeys = [String]()
    @State public var ratesDict = [String: Double]()
    @State public var ratesDate = ""
    
    @State public var term = ""
    @State public var amount = ""
    
    @State private var header = "Exchange Rates"
    
    
    var body: some View {
        VStack{
            Text(header)
                .bold()
            Text(ratesDate)
                .foregroundColor(.gray)
            
            HStack{
                TextField("Type in currency code eg. USD", text: $term)
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                Button("Go"){
                    if term.count == 3{
                        getRates(currency: term.uppercased(), amount: Double(amount) ?? 1)
                        
                        /*if ratesKeys.contains(term.uppercased()) == false{
                            self.term = "EUR"
                        }*/
                        
                        self.header = "Exchange Rates for \(term.uppercased())"
                        
                    }
                }
            }.padding()
            
            List{
                ForEach(ratesDict.sorted(by:<), id: \.key){key, value in
                        HStack{
                            Text(key)
                            Text("•")
                            Text(String(value))
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
