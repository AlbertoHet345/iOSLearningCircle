//
//  ProductListView.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 13/06/23.
//

import SwiftUI

struct ProductListView: View {
    @State var products: [Product] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<products.count, id: \.self) { index in
//                    Text("\(products[index].title)")
                    ProductRowView(product: products[index])
                        .onTapGesture {
                            NavigationLink {
                                ProductDetailView(product: products[index])
                            } label: {
                                Text("")
                            }

                        }
                }
            }
            .navigationTitle(Text("Products"))
            
            .onAppear {
                Task {
                    do {
                        let wrapped = try await HTTPClient.load()
                        products = wrapped.items
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
