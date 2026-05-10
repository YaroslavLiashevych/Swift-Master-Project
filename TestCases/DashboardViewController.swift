//
//  DashboardViewController.swift
//  
//
//  Created by Yaroslav Liashevych on 10.05.2026.
//

import UIKit

// MARK: - Protocols
protocol DashboardDelegate: AnyObject {
    func didUpdateDashboardData()
}

// MARK: - Main View Controller
class DashboardViewController: UIViewController {

    // ❌ ПОМИЛКА: DelegateRule (Відсутнє weak)
    var delegate: DashboardDelegate?

    // ❌ ПОМИЛКА: MagicNumberRule (Що таке 1?)
    var userRole: Int = 1
    var rawData: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // ❌ ПОМИЛКА: PrintRule
        print("Завантаження DashboardViewController")
        fetchDataAndSetupUI()
    }

    // ❌ ПОМИЛКА: Архітектура (Massive Class / High Complexity). Змішування UI та бізнес-логіки.
    func fetchDataAndSetupUI() {
        let urlString = "https://api.myservice.com/v1/dashboard?role=\(userRole)"
        let url = URL(string: urlString)! // ❌ ПОМИЛКА: ForceUnwrapRule

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            // ❌ ПОМИЛКА: MemorySafetyRule (Retain Cycle)
            self.rawData["lastFetch"] = Date()

            if let data = data {
                do {
                    // ❌ ПОМИЛКА: Небезпечний Force Cast (as!)
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // ❌ ПОМИЛКА: High Cyclomatic Complexity (Дуже глибока вкладеність, так званий "Pyramid of Doom")
                    if let items = json["items"] as? [[String: Any]] {
                        for item in items {
                            if let isActive = item["active"] as? Bool {
                                if isActive {
                                    if let type = item["type"] as? String {
                                        if type == "premium" {
                                            // ❌ ПОМИЛКА: MagicNumberRule (100)
                                            if let score = item["score"] as? Int, score > 100 {
                                                // ❌ ПОМИЛКА: PrintRule
                                                print("Знайдено активний преміум елемент!")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    // ❌ ПОМИЛКА: EmptyCatchRule
                }
            }

            DispatchQueue.main.async {
                // Пряме оновлення UI з мережевого методу
                self.view.backgroundColor = .white
                self.delegate?.didUpdateDashboardData()
            }
        }
        task.resume()
    }
}

