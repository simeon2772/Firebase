//
//  FavoritesView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 14.08.24.
//

import SwiftUI

@MainActor
struct FavoritesView: View {
    @State private var viewModel = FavouriteViewModel()

    
    var body: some View {
        List {
            ForEach(viewModel.userFavoriteProducts, id: \.id.self) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                    .contextMenu {
                        Button("Remove from favorites") {
                            viewModel.removeFromFavorites(favoriteProductId: item.id)
                        }
                    }
            }
        }
        .navigationTitle("Favorites")
        .onFirstAppear {
            viewModel.addListnerForFavorites()
        }
//        .onAppear {
//            if !didAppear {
//                viewModel.addListnerForFavorites()
//                didAppear = true
//            }
//        }
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
    }
}


