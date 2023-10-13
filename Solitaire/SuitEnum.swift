//
//  SuitEnum.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/8/23.
//

import Foundation

enum Suit: Int {
    
    case spades, hearts, clubs, diamonds, empty
    
    func isRed() -> Bool {
        
        switch(self) {
        case .spades:
            return false
        case .hearts:
            return true
        case .clubs:
            return false
        case .diamonds:
            return true
        case .empty:
            return false
            
        }
        
    }
    
}
