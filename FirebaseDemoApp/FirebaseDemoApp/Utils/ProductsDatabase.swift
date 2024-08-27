//
//  ProductsDatabase.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 13.08.24.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Identifiable, Codable, Equatable {
    let id: Int
    let title, description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let images: [String]?
    let thumbnail: String?
    
    var ID: String {
        String(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case images
        case thumbnail
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

//    func downloadProductsAndUploadToFirebase() {
//        // https://dummyjson.com/products
//        guard let url = URL(string: "https://dummyjson.com/products") else { return }
//
//        Task {
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                print("Data is here!")
//                let products = try JSONDecoder().decode(ProductArray.self, from: data)
//                print("Data is decoded")
//                let productArray = products.products
//                for product in productArray {
//                    try ProductsManager.shared.uploadProduct(product: product)
//                }
//                print("SUCCESS")
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
