import Foundation

struct TriangularArray<T> : Sequence, ExpressibleByArrayLiteral {
    
    var innerArray: [[T]]
    let rowCount: Int
    
}

