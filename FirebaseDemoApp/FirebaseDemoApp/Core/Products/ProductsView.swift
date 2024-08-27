//
//  ProductsView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 13.08.24.
//

import SwiftUI

@MainActor
struct ProductsView: View {
    @State private var viewModel = ProductsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                ProductsCellView(product: product)
                    .contextMenu {
                        Button("Add to favorite") {
                            viewModel.addUserFavoriteProduct(productId: product.id)
                        }
                    }
                
                if product == viewModel.products.last {
                    ProgressView()
                        .onAppear {
                            viewModel.getProducts()
                        }
                }
            }
        }
        .navigationTitle("Products")
        .onAppear {
            viewModel.getProducts()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "None")") {
                    ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { filter in
                        Button(filter.rawValue) {
                            Task {
                                try await viewModel.filterSelected(filter: filter)
                            }
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Brand: \(viewModel.selectedBrand?.rawValue ?? "None")") {
                    ForEach(ProductsViewModel.BrandOption.allCases, id: \.self) { brand in
                        Button(brand.rawValue) {
                            Task {
                                try await viewModel.brandSelected(brand: brand)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
