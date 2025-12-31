//
//  UserSample.swift
//  FichasAnestésicas
//
//  Created by Renan Wrobel on 30/12/25.
//
import Foundation

extension User {
    /// Sample instance for previews/tests. Extensions cannot have stored instance properties,
    /// so expose this as a static property on `User`.
    static var sampleUser: User {
        User(
            userId: "56A8D8C6-3143-4D75-A90D-E4B57C40ADAC",
            name: "Renan Dantas Wrobel",
            crm: "4794-RO",
            rqe: "2516",
            phone: "(69) 98132-8798",
            emailAddress: "renandw@me.com",
            createdAt: createDate(day: 25, month: 11, year: 2025, hour: 10, minute: 29, second: 4),
            updatedAt: createDate(day: 2, month: 12, year: 2025, hour: 22, minute: 45, second: 22)
        )
    }
        /// Private helper to build dates for the sample.
        private static func createDate(day: Int, month: Int, year: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            components.hour = hour
            components.minute = minute
            components.second = second
            return Calendar.current.date(from: components) ?? Date()
        }
    
}

