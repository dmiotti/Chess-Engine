//
//  Bishop.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

final public class Bishop: Piece {
    private static let candidateMoveVectorCoordinates: [Coordinate] = [ -9, -7, -7, -9 ]
    
    convenience init(position: Coordinate, alliance: Alliance) {
        self.init(position: position, alliance: alliance)
    }
    
    public override func calculateLegalMoves(board: Board) -> [Move] {
        var legalMoves = [Move]()
        
        Bishop.candidateMoveVectorCoordinates.forEach {
            var candidate: Coordinate = position
            
            while BoardUtils.isValidTileCoordinate(candidate) {
                let isFirstColumnExclusion = Bishop.isFirstColumnExclusion(current: position, candidate: $0)
                let isEighthColumnExclusion = Bishop.isEighthColumnExclusion(current: position, candidate: $0)
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
        return BoardUtils.firstColumn[position] && [-9, 7].contains(offset)
    }
    
    private static func isEighthColumnExclusion(current position: Coordinate, candidate offset: Int) -> Bool {
        return BoardUtils.eighthColumn[position] && [-7, 9].contains(offset)
    }

    public override var description: String {
        return PieceType.Bishop.description
    }
}
