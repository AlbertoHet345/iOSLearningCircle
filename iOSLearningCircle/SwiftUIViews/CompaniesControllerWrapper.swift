//
//  CompaniesControllerWrapper.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 12/07/23.
//

import SwiftUI

struct CompaniesControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let companiesController = CompaniesController(style: .insetGrouped)
        let navigationController = UINavigationController(rootViewController: companiesController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No code needed
    }
}
