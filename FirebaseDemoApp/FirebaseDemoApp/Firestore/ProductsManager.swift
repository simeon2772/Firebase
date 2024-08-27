//
//  ProductsManager.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 13.08.24.
//

import Foundation
import FirebaseFirestore

final class ProductsManager {
    
    static let shared = ProductsManager()
    
    private init() { }
    
    private let productsCollection = Firestore.firestore().collection("products")
    
    private func productDocument(productId: String) -> DocumentReference {
        productsCollection.document(productId)
    }
    
    func uploadProduct(product: Product) throws {
        try productDocument(productId: product.ID).setData(from: product, merge: false)
    }
    
    func getProduct(productId: String) async throws -> Product {
        try await productDocument(productId: productId).getDocument(as: Product.self)
    }
//    
//    private func getAllProducts() async throws -> [Product] {
//        try await productsCollection.getDocuments(as: Product.self)
//    }
//    
//    private func getAllProductsSortedByPrice(descending: Bool) async throws -> [Product]{
//        try await productsCollection.order(by: Product.CodingKeys.price.rawValue, descending: descending).getDocuments(as: Product.self)
//    }
//    
//    private func getAllProductsForBrand(brand: String) async throws -> [Product]{
//        try await productsCollection.whereField(Product.CodingKeys.brand.rawValue, isEqualTo: brand).getDocuments(as: Product.self)
//    }
//    
//    private func getAllProductsByPriceAndBrand(descending: Bool, brand: String) async throws -> [Product] {
//        try await productsCollection
//            .whereField(Product.CodingKeys.brand.rawValue, isEqualTo: brand)
//            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
//            .getDocuments(as: Product.self)
//    }
    
    private func getAllProductsQuary() -> Query {
        productsCollection
    }
    
    private func getAllProductsSortedByPriceQuary(descending: Bool) -> Query{
        productsCollection.order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    
    private func getAllProductsForBrandQuary(brand: String) -> Query{
        productsCollection.whereField(Product.CodingKeys.brand.rawValue, isEqualTo: brand)
    }
    
    private func getAllProductsByPriceAndBrandQuary(descending: Bool, brand: String) -> Query {
        productsCollection
            .whereField(Product.CodingKeys.brand.rawValue, isEqualTo: brand)
            .order(by: Product.CodingKeys.price.rawValue, descending: descending)
    }
    
    func getAllProducts(priceDescending: Bool?, forBrand: String?, count: Int, lastDocument: DocumentSnapshot?) async throws -> ([Product], DocumentSnapshot?) {
        var query: Query = getAllProductsQuary()
        
        
        
        if let priceDescending, let forBrand {
            query = getAllProductsByPriceAndBrandQuary(descending: priceDescending, brand: forBrand)
        } else if let priceDescending {
            query = getAllProductsSortedByPriceQuary(descending: priceDescending)
        } else if let forBrand {
            query = getAllProductsForBrandQuary(brand: forBrand)
        }
        
        return try await query.startOptionally(afterDocument: lastDocument).getDocumentsWithSnapshot(as: Product.self)
    }
    
//    func getProductByRating(count: Int, lastRating: Double?) async throws -> [Product] {
//        try await productsCollection
//            .order(by: Product.CodingKeys.rating.rawValue, descending: true)
//            .limit(to: count)
//            .start(after: [lastRating ?? 99999])
//            .getDocuments(as: Product.self)
//    }
    
    func getProductByRating(count: Int, lastDocument: DocumentSnapshot?) async throws -> ([Product], DocumentSnapshot?) {
        if let lastDocument {
            return try await productsCollection
                .order(by: Product.CodingKeys.rating.rawValue, descending: true)
                .limit(to: count)
                .start(afterDocument: lastDocument)
                .getDocumentsWithSnapshot(as: Product.self)
        }  else {
            return try await productsCollection
                .order(by: Product.CodingKeys.rating.rawValue, descending: true)
                .limit(to: count)
                .getDocumentsWithSnapshot(as: Product.self)
        }
    }
    
    func getAllProductsCount() async throws -> Int {
        try await productsCollection.aggregateCount()
    }
}


