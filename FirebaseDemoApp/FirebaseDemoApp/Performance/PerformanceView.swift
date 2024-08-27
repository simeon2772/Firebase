//
//  PerformanceView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 16.08.24.
//

import SwiftUI
import FirebasePerformance
import FirebasePerformanceTarget

struct PerformanceView: View {
    @State private var title = "some title"
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                configure()
                downloadProductsAndUploadToFirebase()
            }
    }
    
    private func configure() {
        let trace = Performance.startTrace(name: "performance_view_loading")
        trace?.setValue(title, forAttribute: "title_text")
        
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            trace?.setValue("Started downloading", forAttribute: "func_state")
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            trace?.setValue("Continued downloading", forAttribute: "func_state")
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            trace?.setValue("Finished downloading", forAttribute: "func_state")
            
            trace?.stop()
        }
    }
    
    func downloadProductsAndUploadToFirebase() {
        let urlString = "https://dummyjson.com/products"
        guard let url = URL(string: urlString), let metric = HTTPMetric(url: url, httpMethod: .get) else { return }
        metric.start()
        Task {
            do {
                let (data, responce) = try await URLSession.shared.data(from: url)
                if let responce = responce as? HTTPURLResponse {
                    metric.responseCode = responce.statusCode
                }
                metric.stop()
            } catch {
                print(error.localizedDescription)
                metric.stop()
            }
        }
    }
}

#Preview {
    PerformanceView()
}

