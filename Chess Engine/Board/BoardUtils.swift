//
//  BoardUtils.swift
//  Chess Engine
//
//  Created by David Miotti on 11/03/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

open class BoardUtils {
    /// An array of boolean indicating if a position is in first column
    static public let firstColumn = initColumn(0)
    /// An array of boolean indicating if a position is in second column
    static public let secondColumn = initColumn(1)
    /// An array of boolean indicating if a position is in seventh column
    static public let seventhColumn = initColumn(6)
    /// An array of boolean indicating if a position is in eighth column
    static public let eighthColumn = initColumn(7)

    /// An array of boolean indicating if a position is in second row
    static public let secondRow = initRow(1)
    /// An array of boolean indicating if a position is in seventh row
    static public let seventhRow = initRow(6)
    
    /// The number of square in the chess board
    static public let numberOfTiles = 64
    /// The number of square in a row
    static public let numberOfTilesPerRow = 8
    
    /// Initialize all positions that are in the column number
    ///
    /// - Parameter columnNumber: The column number where positions should be calculated
    /// - Returns: An array of booleans where true are positions in the column number provided
    static private func initColumn(_ columnNumber: Int) -> [Bool] {
        var column = [Bool](repeating: false, count: numberOfTiles)
        var number = columnNumber
        repeat {
            column[number] = true
            number += numberOfTilesPerRow
        } while number < numberOfTiles
        return column
    }

    /// Initialize all positions that are in the row number
    ///
    /// - Parameter rowNumber: The row number where positions should be calculated
    /// - Returns: An array of booleans where true are positions in the row number provided
    static private func initRow(_ rowNumber: Int) -> [Bool] {
        var row = [Bool](repeating: false, count: numberOfTiles)
        var number = rowNumber
        repeat {
            row[number] = true
            number += 1
        } while number % numberOfTilesPerRow != 0
        return row
    }
    
    /// This class cannot be instanciated
    private init() {}
    
    /// Check if a coordinate is present on a chess board
    ///
    /// - Parameter coordinate: The coordinate to check
    /// - Returns: true if the coordinate is valid. Otherwise return false.
    open static func isValidTileCoordinate(_ coordinate: Coordinate) -> Bool {
        return coordinate >= 0 && coordinate < numberOfTiles
    }
}
