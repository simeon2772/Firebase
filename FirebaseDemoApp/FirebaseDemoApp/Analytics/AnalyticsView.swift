//
//  AnalyticsView.swift
//  FirebaseDemoApp
//
//  Created by Simeon Ivanov on 16.08.24.
//

import SwiftUI
import FirebaseAnalytics

final class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    private init() {}

    func logEvent(name: String, params: [String:Any]? = nil) {
        Analytics.logEvent(name, parameters: params)
    }
    
    func setUserId(userId: String) {
        Analytics.setUserID(userId)
    }
    
    func setUserProperty(value: String?, property: String) {
        Analytics.setUserProperty(value, forName: property)
    }
    
    
    
}

struct AnalyticsView: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Click Me") {
                AnalyticsManager.shared.logEvent(name: "AnalyticsView_ButtonClicked")
            }
            
            Button("Click Me too!") {
                AnalyticsManager.shared.logEvent(name: "AnalyticsView_SecondaryButtonClicked")
            }
        }
        .onAppear {
            //
        }
    }
}

#Preview {
    AnalyticsView()
}
