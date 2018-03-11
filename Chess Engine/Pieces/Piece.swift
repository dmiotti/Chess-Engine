//
//  Piece.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

open class Piece {
    public enum Direction: Int {
        case forward = 1
        case backward = -1
    }
    
    public enum Alliance {
        case white
        case black
        
        public var direction: Direction {
            switch self {
            case .black:
                return .backward
            case .white:
                return .forward
            }
        }
        
        var isWhite: Bool {
            return self == .white
        }
        
        var isBack: Bool {
            return self == .black
        }
    }
    
    open let position: Coordinate
    open let alliance: Alliance
    open let isFirstMove: Bool
    
    private init(position: Coordinate, alliance: Alliance) {
        self.position = position
        self.alliance = alliance
        self.isFirstMove = true
    }
    
    open func calculateLegalMoves(board: Board) -> [Move] {
        fatalError("You must inherit from Piece class")
    }
}
