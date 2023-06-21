//
//  ProductDetailView.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 20/06/23.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text(product.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("$\(product.price)")
            }
            
            Text(product.description)
                .font(.body)
            
            
//            AsyncImage()
        }
        .padding(16)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(title: "iPhone 9",
                                           price: 549,
                                           description: "An apple mobile which is nothing like apple",
                                           images: [
                                               "https://i.dummyjson.com/data/products/1/1.jpg",
                                               "https://i.dummyjson.com/data/products/1/2.jpg",
                                               "https://i.dummyjson.com/data/products/1/3.jpg",
                                               "https://i.dummyjson.com/data/products/1/4.jpg",
                                               "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
                                           ]))
    }
}
