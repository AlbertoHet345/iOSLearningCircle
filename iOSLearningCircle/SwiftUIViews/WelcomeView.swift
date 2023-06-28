//
//  WelcomeView.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 28/06/23.
//

import SwiftUI

struct WelcomeView: View {
    @State var present: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {

                Button {
                    present = true
                } label: {
                    Text("Go to product list")
                }
                
                Button {
                    //
                } label: {
                    Text("Go to company list")
                }

            }
            .navigationDestination(isPresented: $present) {
                ProductListView()
            }
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
