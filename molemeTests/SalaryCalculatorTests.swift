#if canImport(XCTest)
import XCTest
@testable import moleme

final class SalaryCalculatorTests: XCTestCase {
    func testBasicCalculation() {
        // Correct formula: monthlySalary / (workDays * workHours * 3600)
        // 10000 / (22 * 8 * 3600) = 10000 / 633600 = 0.01578...
        let calc = SalaryCalculator(monthlySalary: 10000, workDays: 22, workHours: 8)
        XCTAssertEqual(calc.perSecond, 0.0158, accuracy: 0.001)
    }

    func testZeroSalary() {
        let calc = SalaryCalculator(monthlySalary: 0, workDays: 22, workHours: 8)
        XCTAssertEqual(calc.perSecond, 0.0)
    }

    func testZeroHours() {
        let calc = SalaryCalculator(monthlySalary: 10000, workDays: 22, workHours: 0)
        XCTAssertEqual(calc.perSecond, 0.0)
    }

    func testZeroDays() {
        let calc = SalaryCalculator(monthlySalary: 10000, workDays: 0, workHours: 8)
        XCTAssertEqual(calc.perSecond, 0.0)
    }
}
#else
enum _SalaryCalculatorTestsPlaceholder {}
#endif
