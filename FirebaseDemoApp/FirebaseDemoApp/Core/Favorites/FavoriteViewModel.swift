//
//  FavoriteViewModel.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 15.08.24.
//

import Foundation
import Observation
import Combine

@MainActor
@Observable
final class FavouriteViewModel {
    private(set) var userFavoriteProducts: [UserFavouriteProduct] = []
    private var cancellables = Set<AnyCancellable>()
    
    func addListnerForFavorites() {
        guard let authDataResult = try? AuthManager.shared.getAuthenticatedUser() else { return }
        
        //        UserManager.shared.addListenerForAllUserFavoriteProducts(userId: authDataResult.uid) { [weak self] products in
        //            self?.userFavoriteProducts = products
        
        UserManager.shared.addListenerForAllUserFavoriteProducts(userId: authDataResult.uid)
            .sink { completion in
                
            } receiveValue: { [weak self] products in
                self?.userFavoriteProducts = products
            }
            .store(in: &cancellables)
        
    }
    
    func removeFromFavorites(favoriteProductId: String) {
        Task {
            let authDataResult = try AuthManager.shared.getAuthenticatedUser()
            try await UserManager.shared.removeUserFavoriteProduct(userId:authDataResult.uid, favoriteProductId: favoriteProductId)
            //            getFavorites()
        }
    }
}
