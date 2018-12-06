import Foundation

struct TriangularArray<T> : Sequence, ExpressibleByArrayLiteral {
    
    var innerArray: [[T]]
    let rowCount: Int
    
    init(rowCount: Int, defaultValue: T) {
        self.rowCount = rowCount
        self.innerArray = []
        for i in 0..<rowCount {
            innerArray.append(Array(repeating: defaultValue, count: i + 1))
        }
    }
    
    subscript(_ row: Int, _ index: Int) -> T? {
        get {
            if row < 0 || row >= innerArray.count {
                return nil
            }
            if index < 0 || index > row {
                return nil
            }
            return innerArray[row][index]
        }
        
        set {
            if row < 0 || row >= innerArray.count {
                return
            }
            if index < 0 || index > row {
                return
            }
            innerArray[row][index] = newValue!
        }
    }
    
    func makeIterator() -> TriangularArray<T>._Iterator {
        return _Iterator(triangularArray: self, currentRow: -1, currentIndex: -1)
    }
    
    func adjacentIndices(forRow row: Int, index: Int) -> [(Int, Int)] {
        let possibleIndices = [
            (row - 1, index - 1),
            (row - 1, index),
            (row, index - 1),
            (row, index + 1),
            (row + 1, index),
            (row + 1, index + 1),
        ]
        return possibleIndices.filter {
            (0..<rowCount).contains($0.0) && (0...$0.0).contains($0.1)
        }
    }
    
    func adjacentElements(forRow row: Int, index: Int) -> [T] {
        return adjacentIndices(forRow: row, index: index).map { self[$0.1, $0.1]! }
    }
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        rowCount = elements.count
        innerArray = elements
    }
    
    typealias Element = T
    typealias Iterator = _Iterator
    typealias ArrayLiteralElement = [T]
    
    struct _Iterator : IteratorProtocol {
        let triangularArray: TriangularArray
        var currentRow: Int
        var currentIndex: Int
        
        mutating func next() -> T? {
            currentIndex += 1
            if currentIndex > currentRow {
                currentIndex = 0
                currentRow += 1
            }
            if currentRow >= triangularArray.rowCount {
                return nil
            }
            return triangularArray[currentRow, currentIndex]
        }
        
        typealias Element = T
    }
}

