//
//  ProductRowView.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 20/06/23.
//

import SwiftUI

struct ProductRowView: View {
    let product: Product
    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: product.images[0]) {
                AsyncImage(url: url) { image in
                    image
                } placeholder: {
                    Image(systemName: "questionmark.folder")
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                
            }
            
            Text(product.title)
                .font(.system(size: 22))
                .fontWeight(.bold)
            
        }
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product:
                        Product(title: "iPhone 9",
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
