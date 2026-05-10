//
//  AppConfig.swift
//  
//
//  Created by Yaroslav Liashevych on 10.05.2026.
//

import Foundation

// MARK: - App Configuration
struct AppConfig {
    // ❌ ПОМИЛКА: SecurityRule (Захардкоджений токен доступу)
    static let stripeSecretKey = "dummy_stripe_secret_for_test_123"
    static let mixpanelToken = "dummy_mixpanel_token_456"

    // ❌ ПОМИЛКА: MagicNumberRule (Що таке 3? Що таке 86400?)
    static let maxRetryCount = 3
    static let sessionTimeout: TimeInterval = 86400
}

// MARK: - Auth Manager
class AuthManager {
    static let shared = AuthManager()

    var currentUserToken: String?

    func login(with email: String?) {
        // ❌ ПОМИЛКА: ForceUnwrapRule (Може викликати краш, якщо email == nil)
        let safeEmail = email!

        print("Спроба логіну для: \(safeEmail)") // ❌ ПОМИЛКА: PrintRule

        let url = URL(string: "https://api.myservice.com/v1/auth")! // ❌ Ще один Force Unwrap

        var request = URLRequest(url: url)
        request.addValue("Bearer \(AppConfig.stripeSecretKey)", forHTTPHeaderField: "Authorization")

        // Імітація запиту...
        if safeEmail.count > 50 { // ❌ ПОМИЛКА: MagicNumberRule (50)
            print("Email надто довгий")
        }
    }

    func forceLogout() {
        self.currentUserToken = nil
        // ❌ ПОМИЛКА: PrintRule (використання print замість Logger)
        print("Користувача примусово розлогінено")
    }
}

