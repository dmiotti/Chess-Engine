//
//  Move.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

/// Represent a move
open class Move: Equatable {
    /// The board
    public let board: Board
    /// The piece
    public let piece: Piece
    /// The destination position
    public let destinationCoordinate: Coordinate
    
    /// Initialize a new move instance
    ///
    /// - Parameters:
    ///   - board: The board where the move reside
    ///   - piece: The piece associated with the move
    ///   - destinationCoordinate: The coordinate of the final position of the piece
    private init(board: Board, piece: Piece, destinationCoordinate: Coordinate) {
        self.board = board
        self.piece = piece
        self.destinationCoordinate = destinationCoordinate
    }
    
    /// Represent a move without capture/
    open class MajorMove: Move {
        override public init(board: Board, piece: Piece, destinationCoordinate: Coordinate) {
            super.init(board: board, piece: piece, destinationCoordinate: destinationCoordinate)
        }
    }
    
    /// Represent a move that attack an opponent piece
    open class AttackMove: Move {
        public let attackedPiece: Piece
        
        public init(board: Board, piece: Piece, destinationCoordinate: Coordinate, attackedPiece: Piece) {
            self.attackedPiece = attackedPiece
            super.init(board: board, piece: piece, destinationCoordinate: destinationCoordinate)
        }
    }

    public static func ==(lhs: Move, rhs: Move) -> Bool {
        return lhs.piece == rhs.piece && lhs.destinationCoordinate == rhs.destinationCoordinate
    }
}
