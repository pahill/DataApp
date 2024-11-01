//
//  ContentView.swift
//  DataApp1
//
//  Created by Pamela Hill on 2024/10/31.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Button("Get and save launches") {
                Task {
                    do {
                        let launches = try await performAPICall()
                        print(launches)
                        let joined = try JSONEncoder().encode(launches)
                        UserDefaults.standard.set(joined, forKey: "launches")
                        print("Saved to UserDefaults")
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .padding()
    }
}

func performAPICall() async throws -> [Launch] {
    let url = URL(string: "https://api.spacexdata.com/v3/launches")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Launch].self, from: data)
}

struct Launch: Codable {
    let flight_number: Int
    let mission_name: String
    let launch_date_utc: String
    let details: String?
    let launch_success: Bool?
}


