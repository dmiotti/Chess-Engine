//
//  MoveTransition.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

public enum MoveStatus {
    case done
    case illegalMove
}

open class MoveTransition {
    public let transitionBoard: Board
    public let move: Move
    public let moveStatus: MoveStatus

    init(board: Board, move: Move, moveStatus: MoveStatus) {
        self.transitionBoard = board
        self.move = move
        self.moveStatus = moveStatus
    }
}
