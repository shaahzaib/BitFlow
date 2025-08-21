//
//  Formatter.swift
//  BitFlow
//
//  Created by Macbook Pro on 29/06/2025.
//

import Foundation

extension Double{
    
    
    // to convert the numbr upto 2 decimal places
    private var currencyFormatter2 : NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
    
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    
    // convert the currency to string
    
    func asCurrencyWith2Decimals() -> String{
        
        let number = NSNumber(value: self)
        
        return currencyFormatter2.string(from: number) ?? "$0.00 "
        
        
    }
    
    
    
    
    
    // convert the double to currency
     
    private var currencyFormatter : NumberFormatter{
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
    
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        
        return formatter
    }
    
    
    // convert the currency to string
    
    func asCurrency() -> String{
        
        let number = NSNumber(value: self)
        
        return currencyFormatter.string(from: number) ?? "$0.00 "
        
        
    }
    
    // convert the number upto 2 decimal points
    
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    
    
    //convert the numberString into percentage format
    func asPercentString() -> String{
        
        return asNumberString()+"%"
    }
    
    
    /*
     convert the doubles in string with K,M,Bn,Tr abbreviations
     12 to 12.00
     1234 to 1.23K
     12345678 to 12.34M
     1234567890 to 1.23Bn
     12345678901234 to 1.23Tr
     
     */
    
    func FormatwithAbbreviation() -> String{
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
            
        case 0...:
            return self.asNumberString()
            
        default:
            return "\(sign)\(self)"
        }
    }
}
