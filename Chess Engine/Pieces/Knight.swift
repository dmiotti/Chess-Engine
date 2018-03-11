//
//  Knight.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

final public class Knight: Piece {
    private static let candidateMoveCoordinateOffsets: [Coordinate] = [ -17, -15, -10, -6,  6, 10, 15, 17 ]

    init(position: Coordinate, alliance: Alliance) {
        super.init(position: position, alliance: alliance, pieceType: .knight)
    }
    
    public override func calculateLegalMoves(board: Board) -> [Move] {
        return Knight.candidateMoveCoordinateOffsets.flatMap {
            let candidate: Coordinate = position + $0
            
            let isValidCoordinate = BoardUtils.isValidTileCoordinate(candidate)
            let isFirstColumnExclusion = Knight.isFirstColumnExclusion(current: position, candidate: $0)
            let isSecondColumnExclusion = Knight.isSecondColumnExclusion(current: position, candidate: $0)
            let isSeventhColumnExclusion = Knight.isSeventhColumnExclusion(current: position, candidate: $0)
            let isEighthColumnExclusion = Knight.isEighthColumnExclusion(current: position, candidate: $0)
            
            if isValidCoordinate, !isFirstColumnExclusion, !isSecondColumnExclusion, !isSeventhColumnExclusion, !isEighthColumnExclusion {
                let tile = board[candidate]
                if !tile.isOccupied {
                    return Move.MajorMove(board: board, piece: self, destinationCoordinate: candidate)
                }
                if let pieceAtDestination = tile.piece, alliance != pieceAtDestination.alliance {
                    return Move.AttackMove(board: board, piece: self, destinationCoordinate: candidate, attackedPiece: pieceAtDestination)
                }
            }
            
            return nil
        }
    }
    
    private static func isFirstColumnExclusion(current position: Coordinate, candidate offset: Coordinate) -> Bool {
        return BoardUtils.firstColumn[position] && [-17, -10, 6, 15].contains(offset)
    }
    
    private static func isSecondColumnExclusion(current position: Coordinate, candidate offset: Coordinate) -> Bool {
        return BoardUtils.secondColumn[position] && [-10, 6].contains(offset)
    }
    
    private static func isSeventhColumnExclusion(current position: Coordinate, candidate offset: Coordinate) -> Bool {
        return BoardUtils.seventhColumn[position] && [-6, 10].contains(offset)
    }
    
    private static func isEighthColumnExclusion(current position: Coordinate, candidate offset: Coordinate) -> Bool {
        return BoardUtils.eighthColumn[position] && [-15, -6, 10, 17].contains(offset)
    }
}
