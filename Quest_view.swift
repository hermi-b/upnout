//
//  QuestService.swift
//  upnout
//
//  Created by Hermela Benyam on 4/11/25.
//

import Foundation
struct QuestService {
    static func fetchQuest(lat: Double, lon: Double, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/generate-quest") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Double] = ["latitude": lat, "longitude": lon]
        print("Latitude: \(lat), Longitude: \(lon)")

        
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown")")
                return
            }

            if let decoded = try? JSONDecoder().decode([String: String].self, from: data),
               let quest = decoded["quest"] {
                DispatchQueue.main.async {
                    completion(quest)
                }
            }
        }.resume()
    }
}
