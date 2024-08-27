//
//  ProductsViewModel.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 15.08.24.
//

import Foundation
import Observation
import FirebaseFirestore

@MainActor
@Observable
final class ProductsViewModel {
    private(set) var products: [Product] = []
    var selectedFilter: FilterOption? = nil
    var selectedBrand: BrandOption? = nil
    
    @ObservationIgnored
    private var lastDocument: DocumentSnapshot? = nil
    
    enum FilterOption: String, CaseIterable {
        case priceHigh = "High Price"
        case priceLow = "Low Price"
        case noFilter = "No Filter"
        
        var priceDescending: Bool? {
            switch self {
            case .priceHigh:
                return true
            case .priceLow:
                return false
            case .noFilter:
                return nil
            }
        }
    }
    
    func filterSelected(filter: FilterOption) async throws {
        self.selectedFilter = filter
        self.products = []
        self.lastDocument = nil
        self.getProducts()
    }
    
    enum BrandOption: String, CaseIterable {
        case noBrand = "No Brand"
        case annibale = "Annibale Colombo"
        case dior = "Dior"
        
        var brandKey: String? {
            if self == .noBrand {
                return nil
            }
            
            return self.rawValue
        }
    }
    
    func brandSelected(brand: BrandOption) async throws {
        self.selectedBrand = brand
        self.products = []
        self.lastDocument = nil
        self.getProducts()
    }
    
    func getProducts() {
        Task {
            let (newProducts, lastDocument) = try await ProductsManager.shared.getAllProducts(priceDescending: selectedFilter?.priceDescending, forBrand: selectedBrand?.brandKey, count: 10, lastDocument: lastDocument)
            
            self.products.append(contentsOf: newProducts)
            if let lastDocument {
                self.lastDocument = lastDocument
            }
        }
    }
    
    func addUserFavoriteProduct(productId: Int) {
        Task {
            let authDataResult = try AuthManager.shared.getAuthenticatedUser()
            try await UserManager.shared.addUserFavoriteProduct(userId:authDataResult.uid, productId: productId)
        }
    }
}
