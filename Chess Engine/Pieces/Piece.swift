//
//  Piece.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

import Foundation

public enum Alliance {
    case white
    case black
}

open class Piece {
    open let position: Coordinate
    open let alliance: Alliance
    
    init(position: Coordinate, alliance: Alliance) {
        self.position = position
        self.alliance = alliance
    }
    
    open func calculateLegalMoves(board: Board) -> [Move] {
        fatalError("You must inherit from Piece class")
    }
}
