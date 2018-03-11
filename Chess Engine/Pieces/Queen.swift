//
//  Queen.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

import Foundation

final public class Queen: Piece {
    private static let candidateMoveVectorCoordinates: [Coordinate] = [ -9, -8, -7, -1,  1,  7,  8,  9 ]
    
    convenience init(position: Coordinate, alliance: Alliance) {
        self.init(position: position, alliance: alliance)
    }
    
    public override func calculateLegalMoves(board: Board) -> [Move] {
        var legalMoves = [Move]()
        
        Queen.candidateMoveVectorCoordinates.forEach {
            var candidate: Coordinate = position
            
            while BoardUtils.isValidTileCoordinate(candidate) {
                let isFirstColumnExclusion = Queen.isFirstColumnExclusion(current: position, candidate: $0)
                let isEighthColumnExclusion = Queen.isEighthColumnExclusion(current: position, candidate: $0)
                if isFirstColumnExclusion || isEighthColumnExclusion {
                    break
                }
                candidate += $0
                if BoardUtils.isValidTileCoordinate(candidate) {
                    let tile = board[candidate]
                    if !tile.isOccupied {
                        let move = Move.MajorMove(board: board, piece: self, destinationCoordinate: candidate)
                        legalMoves.append(move)
                    } else {
                        if let pieceAtDestination = tile.piece, alliance != pieceAtDestination.alliance {
                            let move = Move.AttackMove(board: board, piece: self, destinationCoordinate: candidate, attackedPiece: pieceAtDestination)
                            legalMoves.append(move)
                        }
                        break // We reach another piece, stop the `while` loop
                    }
                }
            }
        }
        
        return legalMoves
    }
    
    private static func isFirstColumnExclusion(current position: Coordinate, candidate offset: Int) -> Bool {
        return BoardUtils.firstColumn[position] && [-1, -9, 7].contains(offset)
    }
    
    private static func isEighthColumnExclusion(current position: Coordinate, candidate offset: Int) -> Bool {
        return BoardUtils.eighthColumn[position] && [-7, 1, 9].contains(offset)
    }
}
