//
//  PaymentDelegate.swift
//  
//
//  Created by Yaroslav Liashevych on 10.05.2026.

import Foundation

// MARK: - Protocols
protocol PaymentDelegate: AnyObject {
    func paymentDidSucceed(receiptId: String)
    func paymentDidFail(error: Error)
}

// MARK: - Network Service
class PaymentNetworkService {

    // ❌ ПОМИЛКА: DelegateRule (Сильне посилання на делегат, відсутнє ключове слово `weak`)
    var delegate: PaymentDelegate?

    private var paymentHistory: [String] = []

    func processPayment(amount: Double) {
        // ❌ ПОМИЛКА: PrintRule
        print("Починаємо обробку платежу на суму: \(amount)")

        let url = URL(string: "https://api.stripe.com/v1/charges")! // ❌ ПОМИЛКА: Force Unwrap

        // Імітація асинхронного мережевого запиту
        let completionHandler: (Data?, Error?) -> Void = { data, error in

            // ❌ ПОМИЛКА: MemorySafetyRule (Retain Cycle). Замикання сильно захоплює `self`
            self.paymentHistory.append("Оплата на суму \(amount)")
            self.delegate?.paymentDidSucceed(receiptId: "REC_12345")

            guard let responseData = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                // ❌ ПОМИЛКА: PrintRule
                print("Відповідь сервера: \(json)")
            } catch {
                // ❌ ПОМИЛКА: EmptyCatchRule (Помилка парсингу просто "ковтається", ніхто про неї не дізнається)
            }
        }

        // Виконуємо наш "запит"
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let mockData = "{\"status\": \"success\"}".data(using: .utf8)
            completionHandler(mockData, nil)
        }
    }

    func clearHistory() {
        self.paymentHistory.removeAll()
    }
}

