import Foundation

class Distribution {
    func sample() -> Double {
        fatalError("Must override")
    }
    
    func sample(count: Int) -> [Double] {
        return (1...count).map { _ in sample()}
    }
}

class UniformDistribution: Distribution {
    
    var range: ClosedRange<Int>
    
    init(range: ClosedRange<Int>) {
        self.range = range
    }
    
    override func sample() -> Double {
        return Double(Int.random(in: range))
    }
}

let d20 = UniformDistribution(range: 1...20)
d20.sample(count: 10)
