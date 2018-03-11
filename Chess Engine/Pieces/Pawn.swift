//
//  Pawn.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

final public class Pawn: Piece {
    private static let candidateMoveVectorCoordinates: [Coordinate] = [ 8, 16 ]
    
    convenience init(position: Coordinate, alliance: Alliance) {
        self.init(position: position, alliance: alliance)
    }
    
    override public func calculateLegalMoves(board: Board) -> [Move] {
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
            } else if $0 == 7 && ((BoardUtils.eighthColumn[position] && alliance.isWhite) || (BoardUtils.firstColumn[position] && alliance.isBack)) {
                let tile = board[candidate]
                if tile.isOccupied, let piece = tile.piece {
                    if piece.alliance != alliance {
                        // TODO: Add an attack move
                        return Move.AttackMove(board: board, piece: self, destinationCoordinate: candidate, attackedPiece: piece)
                    }
                }
            } else if $0 == 9 && ((BoardUtils.firstColumn[position] && alliance.isWhite) || (BoardUtils.eighthColumn[position] && alliance.isBack)) {
                if let pieceOnCandidate = board[candidate].piece, alliance != pieceOnCandidate.alliance {
                    return Move.MajorMove(board: board, piece: self, destinationCoordinate: candidate)
                }
            }
            
            return nil
        }
    }

    public override var description: String {
        return PieceType.Pawn.description
    }
}
