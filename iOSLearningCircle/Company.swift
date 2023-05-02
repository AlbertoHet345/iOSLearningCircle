//
//  Company.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 02/05/23.
//

import Foundation

struct Company {
    let name: String
    let foundationYear: Int
    let founder: String
}

extension Company {
    static var samples: [Company] {
        [
            Company(name: "Apple", foundationYear: 1976, founder: "Steve Jobs"),
            Company(name: "Google", foundationYear: 1998, founder: "Larry Page"),
            Company(name: "Meta", foundationYear: 2004, founder: "Mark Zuckerberg"),
            Company(name: "Amazon", foundationYear: 1994, founder: "Jeff Bezos"),
            Company(name: "Tesla Motors", foundationYear: 2003, founder: "Elon Musk"),
            Company(name: "Netflix", foundationYear: 1997, founder: "Reed Hastlings"),
            Company(name: "Disney", foundationYear: 1923, founder: "Walt Disney"),
            Company(name: "Ford", foundationYear: 1903, founder: "Henry Ford"),
            Company(name: "Microsoft", foundationYear: 1975, founder: "Bill Gates")
        ]
    }
}
