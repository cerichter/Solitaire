//
//  PileIdentification.swift
//  Solitaire
//
//  Created by Corinne Richter on 10/13/23.
//

import Foundation

enum PileType {
    case stock, foundation, tableau, waste
}

enum PileNumber: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
}

struct PileIdentification {
    
    var pileType: PileType
    var pileNumber: PileNumber

}
