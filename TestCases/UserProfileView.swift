//
//  UserProfileView.swift
//  
//
//  Created by Yaroslav Liashevych on 10.05.2026.
//

import SwiftUI

struct UserProfileView: View {
    @State private var userName: String? = "Ярослав"
    @State private var avatarUrlString: String = "https://example.com/avatar.png"

    var body: some View {
        // ❌ ПОМИЛКА: MagicNumberRule (Незрозуміле число 24 для відступу)
        VStack(spacing: 24) {

            // ❌ ПОМИЛКА: LocalizationRule (Захардкоджений текст, який не підтримує багатомовність)
            Text("Профіль користувача")
                .font(.largeTitle)
                .fontWeight(.bold)

            // ❌ ПОМИЛКА: ForceUnwrapRule (Якщо бекенд пришле кривий лінк, додаток впаде)
            AsyncImage(url: URL(string: avatarUrlString)!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            // ❌ ПОМИЛКА: MagicNumberRule (Захардкоджені розміри фрейму та радіусу)
            .frame(width: 120, height: 120)
            .clipShape(Circle())

            Button(action: {
                // ❌ ПОМИЛКА: ForceUnwrapRule
                let name = userName!

                // ❌ ПОМИЛКА: PrintRule (Залишений print у продакшен UI-коді)
                print("Користувач \(name) натиснув кнопку виходу")
            }) {
                // ❌ ПОМИЛКА: LocalizationRule
                Text("Вийти з акаунта")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red.cornerRadius(8))
            }
        }
        .onAppear {
            // ❌ ПОМИЛКА: PrintRule
            print("UserProfileView успішно відмальовано")
        }
    }
}

