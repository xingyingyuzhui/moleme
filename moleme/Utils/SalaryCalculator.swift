import Foundation

struct SalaryCalculator {
    let monthlySalary: Double
    let workDaysPerMonth: Int
    let workHoursPerDay: Int

    init(monthlySalary: Double, workDaysPerMonth: Int, workHoursPerDay: Int) {
        self.monthlySalary = monthlySalary
        self.workDaysPerMonth = workDaysPerMonth
        self.workHoursPerDay = workHoursPerDay
    }

    init(monthlySalary: Double, workDays: Int, workHours: Int) {
        self.init(monthlySalary: monthlySalary, workDaysPerMonth: workDays, workHoursPerDay: workHours)
    }

    var perSecond: Double {
        guard monthlySalary > 0, workDaysPerMonth > 0, workHoursPerDay > 0 else { return 0.0 }
        let totalSeconds = Double(workDaysPerMonth * workHoursPerDay * 3600)
        guard totalSeconds > 0 else { return 0.0 }
        return monthlySalary / totalSeconds
    }
}
