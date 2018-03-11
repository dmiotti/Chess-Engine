//
//  King.swift
//  Chess Engine Framework
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

final public class King: Piece {
    private static let candidateMoveVectorCoordinates: [Coordinate] = [ -9, -8, -7, -1, 1, 7, 8, 9 ]

    init(position: Coordinate, alliance: Alliance) {
        super.init(position: position, alliance: alliance, pieceType: .king)
    }

    override public func calculateLegalMoves(board: Board) -> [Move] {
        return King.candidateMoveVectorCoordinates.flatMap {
            let candidate = position + $0

            let isFirstExclusion = King.isFirstColumnExclusion(current: position, candidate: $0)
            let isEighthExclusion = King.isEighthColumnExclusion(current: position, candidate: $0)
            if !BoardUtils.isValidTileCoordinate(candidate) || isFirstExclusion || isEighthExclusion {
                return nil
            }

            let tile = board[candidate]
            if !tile.isOccupied {
                // TODO: Check if the destination position is defended by an opponent piece
                return Move.MajorMove(board: board, piece: self, destinationCoordinate: candidate)
            }
            if let piece = tile.piece, alliance != piece.alliance {
                return Move.AttackMove(board: board, piece: self, destinationCoordinate: candidate, attackedPiece: piece)
            }
            return nil
        }
    }

    private static func isFirstColumnExclusion(current position: Coordinate, candidate offset: Int) -> Bool {
        return BoardUtils.firstColumn[position] && [-9, -1, 7].contains(offset)
    }

    private static func isEighthColumnExclusion(current position: Coordinate, candidate offset: Int) -> Bool {
        return BoardUtils.eighthColumn[position] && [-7, 1, 9].contains(offset)
    }
}
