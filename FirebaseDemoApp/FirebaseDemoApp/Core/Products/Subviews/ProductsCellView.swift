//
//  ProductsCellView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 14.08.24.
//

import SwiftUI

struct ProductsCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            
            VStack(alignment: .leading) {
                Text(product.title!)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text("Price: $\(product.price!.formatted())")
                Text("Rating: \(product.rating?.formatted() ?? "")")
                Text("Brand: \(product.brand ?? "n/a")")
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProductsCellView(product: Product(id: 2, title: "fewqf", description: "FEwq", price: 21, discountPercentage: 213, rating: 43, stock: 42, brand: "fewq", images: [], thumbnail: "fqf"))
}
