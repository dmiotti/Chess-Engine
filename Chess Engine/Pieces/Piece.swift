//
//  Piece.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

open class Piece: CustomStringConvertible, Equatable {

    public enum PieceType: String, CustomStringConvertible {
        case pawn   = "p"
        case rook   = "r"
        case knight = "n"
        case bishop = "b"
        case queen  = "q"
        case king   = "k"

        public var description: String {
            return rawValue
        }
    }

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
    open let pieceType: PieceType
    
    init(position: Coordinate, alliance: Alliance, pieceType: PieceType) {
        self.position = position
        self.alliance = alliance
        self.isFirstMove = true
        self.pieceType = pieceType
    }

    public var description: String {
        return pieceType.description
    }
    
    /// Calculate all legals moves for the current piece. This method must be overrided by a concrete piece.
    ///
    /// - Parameter board: The board the piece is
    /// - Returns: An array of moves
    open func calculateLegalMoves(board: Board) -> [Move] {
        fatalError("You must inherit from Piece class")
    }

    public static func ==(lhs: Piece, rhs: Piece) -> Bool {
        return lhs.alliance == rhs.alliance && lhs.pieceType == rhs.pieceType && lhs.position == rhs.position
    }
}
