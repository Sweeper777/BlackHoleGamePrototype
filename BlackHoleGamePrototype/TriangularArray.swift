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
    init(arrayLiteral elements: ArrayLiteralElement...) {
        rowCount = elements.count
        innerArray = elements
    }
    
    typealias Element = T
    typealias Iterator = _Iterator
    typealias ArrayLiteralElement = [T]
    
}

