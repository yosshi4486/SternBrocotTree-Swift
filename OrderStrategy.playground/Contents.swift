import UIKit
import SternBrocotTreeSwift

/*:
# User Order by using Stern Brocot Tree

 ## Float
 If I take float user order strategy, it will run out of digits rapidly.
 */

func floatOrderStrategy() {
    let source: Float64 = 1
    let destination: Float64 = 2
    var current = source

    func average(_ a: Float64, _ b: Float64) -> Float64 {
        return (a + b) / 2
    }

    for i in 0...100 {

        let ave = average(current, destination)

        if ave == current {
            print("Run out.")
            break
        } else {
            current = ave
            print("insert \(i): \(current)")
        }
    }

}

//floatOrderStrategy()

//: You can see `Run out.` in insert 52.

/*:
## Stern Brocot Tree with Fraction
 */

func sternBrocotTreeWithFractionOrderStrategy(iteration: Int) {

    var current: Rational?

    for i in 0...iteration {
        let result = try! intermediate(left: nil, right: current)

        if result == current {
            print("Run out.")
            break
        } else {
            current = result
            print("insert \(i): \(current)")
        }

    }

}

//sternBrocotTreeWithFractionOrderStrategy(iteration: 10000)

//: This strategy is awesome! but it may have some difficulty for connecting DB framework.

/*:
## stern Brocot Tree with Float
 Float is familiar type used in anywhare.
 */

func sternBrocotTreeWithFloatOrderStrategy(iteration: Int) {

    var current: Rational?

    for i in 0...iteration {
        let result = try! intermediate(left: nil, right: current)

        if result.floatValue == current?.floatValue {
            print("Run out.")
            break
        } else {
            current = result
            print("insert \(i): \(current?.floatValue)")
        }

    }

}

sternBrocotTreeWithFloatOrderStrategy(iteration: 10000)
