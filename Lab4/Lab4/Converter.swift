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
            case .USD: return 0.53219797764768493879723257051623
            case .EUR: return 0.48402710551790900290416263310745
            case .RUB: return 30.959752321981424148606811145511
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
