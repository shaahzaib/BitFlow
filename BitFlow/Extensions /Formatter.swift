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
}
