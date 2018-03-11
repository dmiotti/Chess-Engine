//
//  MoveTransition.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

enum MoveStatus {
}

open class MoveTransition {
    let transitionBoard: Board
    let move: Move
    let moveStatus: MoveStatus

    init(board: Board, move: Move, moveStatus: MoveStatus) {
        self.transitionBoard = board
        self.move = move
        self.moveStatus = moveStatus
    }
}
