//
//  WelcomeView.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 28/06/23.
//

import SwiftUI

struct WelcomeView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("This is the iOS Learning Circle project. Please choose one of the options above.")

                NavigationLink {
                    ProductListView()
                } label: {
                    Text("Go to product list")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blue, lineWidth: 2)
                                
                        )
                        .padding()
                }
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Go to company list")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blue, lineWidth: 2)
                                
                        )
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle(Text("Welcome"))
            .sheet(isPresented: $isPresented) {
                CompaniesControllerWrapper()
            }
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
