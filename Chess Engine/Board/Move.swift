//
//  Move.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

import Foundation

open class Move {
    public let board: Board
    public let piece: Piece
    public let destinationCoordinate: Coordinate
    
    private init(board: Board, piece: Piece, destinationCoordinate: Coordinate) {
        self.board = board
        self.piece = piece
        self.destinationCoordinate = destinationCoordinate
    }
    
    open class MajorMove: Move {
        override public init(board: Board, piece: Piece, destinationCoordinate: Coordinate) {
            super.init(board: board, piece: piece, destinationCoordinate: destinationCoordinate)
        }
    }
    
    open class AttackMove: Move {
        open let attackedPiece: Piece
        
        public init(board: Board, piece: Piece, destinationCoordinate: Coordinate, attackedPiece: Piece) {
            self.attackedPiece = attackedPiece
            super.init(board: board, piece: piece, destinationCoordinate: destinationCoordinate)
        }
    }
}
