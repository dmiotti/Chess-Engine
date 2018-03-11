//
//  Pawn.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

import Foundation

final class Pawn: Piece {
    private static let candidateMoveVectorCoordinates: [Coordinate] = [ 8, 16 ]
    
    convenience init(position: Coordinate, alliance: Alliance) {
        self.init(position: position, alliance: alliance)
    }
    
    override func calculateLegalMoves(board: Board) -> [Move] {
        return Pawn.candidateMoveVectorCoordinates.flatMap {
            let candidate: Coordinate = position + (alliance.direction.rawValue * $0)
            
            if !BoardUtils.isValidTileCoordinate(candidate) {
                return nil
            }
            
            if $0 == 8, !board[candidate].isOccupied {
                /// TODO: Deal with pawn promotion
                return Move.MajorMove(board: board, piece: self, destinationCoordinate: candidate)
            }
            
            if $0 == 16 && isFirstMove && ((BoardUtils.secondRow[position] && alliance.isBack) || (BoardUtils.seventhRow[position] && alliance.isWhite)) {
                let behindCandidateDestinationCoordinate: Coordinate = position + (alliance.direction.rawValue * BoardUtils.numberOfTilesPerRow)
                if !board[behindCandidateDestinationCoordinate].isOccupied, !board[candidate].isOccupied {
                    return Move.MajorMove(board: board, piece: self, destinationCoordinate: candidate)
                }
            }
            
            return nil
        }
    }
}