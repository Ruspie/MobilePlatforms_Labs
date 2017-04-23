//
//  File.swift
//  Lab1
//
//  Created by Admin on 08.02.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import Foundation

enum Currency {
    case USD, EUR, RUB
    
    func getRate() -> Double {
        switch self {
        case .USD: return 0.52137
        case .EUR: return 0.48828
        case .RUB: return 31.05590
        }
    }
    
    func fromBYN(amountInBYN: Double) -> Double {
        return self.getRate()*amountInBYN
    }
}

class Converter {
    
    func getAllConvertedAmount(amountInBYN: Double) -> [Currency: Double] {
        return [
            Currency.USD : Currency.USD.fromBYN(amountInBYN: amountInBYN),
            Currency.EUR : Currency.EUR.fromBYN(amountInBYN: amountInBYN),
            Currency.RUB : Currency.RUB.fromBYN(amountInBYN: amountInBYN)
        ]
    }
    
    func getConvertedAmount(amountInBYN: Double, currency: Currency) -> Double {
        return currency.fromBYN(amountInBYN: amountInBYN)
    }
    
    func getRates() -> [Currency: Double] {
        return getAllConvertedAmount(amountInBYN: 1)
    }
    
    func getRate(currency: Currency) -> Double {
        return currency.fromBYN(amountInBYN: 1)
    }
}
