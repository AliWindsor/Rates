//
//  Model.swift
//  XRate
//
//  Created by Alicia Windsor on 22/07/2021.
//

import Foundation

struct RatesResponse: Decodable, Hashable{
    let base: String
    let date: String
    let rates: [String: Double]
}

