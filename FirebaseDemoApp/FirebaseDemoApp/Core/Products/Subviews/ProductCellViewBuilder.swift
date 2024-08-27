//
//  ProductCellViewBuilder.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 14.08.24.
//

import SwiftUI

struct ProductCellViewBuilder: View {
    
    let productId: String
    @State private var product: Product? = nil
    
    var body: some View {
        ZStack {
            if let product {
                ProductsCellView(product: product)
            }
        }
        .task {
            self.product = try? await ProductsManager.shared.getProduct(productId: productId)
        }
    }
}

#Preview {
    ProductCellViewBuilder(productId: "7")
}
