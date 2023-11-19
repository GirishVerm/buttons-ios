//
//  ContentView.swift
//  buttons
//
//  Created by Girish Verma on 2023-11-17.
//

import SwiftUI

struct ContentView: View {
    let data: [[String]] = [
            ["A", "B", "C"],
            ["D", "E", "F"],
            ["G", "H", "I"],
            ["J", "K", "L"]
        ]

        var body: some View {
            VStack {
                ForEach(0..<data.count) { row in
                    HStack {
                        ForEach(0..<data[row].count) { column in
                            Text(data[row][column])
                                .frame(width: 50, height: 50)
                                .border(Color.black) // Add a border for better visualization
                        }
                    }
                }
            }
            .padding()
        }
}

#Preview {
    ContentView()
}
