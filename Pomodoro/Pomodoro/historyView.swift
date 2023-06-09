//
//  historyView.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var days = UserDefaults.standard.object(forKey: "days") as? [String] ?? []
    @Published var history: [String: [String: Int]] = [:]
    
    func updateHistory() {
        for day in days {
            let historyOfDay = UserDefaults.standard.object(forKey: day) as? [String: Int] ?? ["Focus time": 0, "Break time": 0]
            history[day] = historyOfDay
        }
    }
}

struct historyView: View {
    @ObservedObject var viewModel = HistoryViewModel()
    var today: String
    var days = UserDefaults.standard.object(forKey: "days") as? [String] ?? []
    var body: some View {
        VStack {
            Text("History")
                .fontWeight(.bold)
                .padding(.bottom, 26)
            
            List(viewModel.days, id: \.self) {day in
                Section(header: HStack {
                    Text(day)
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    Spacer()
                }.frame(width: 358, height: 26)) {
                    var history = (UserDefaults.standard.object(forKey: day) as? [String: Int] ?? ["Focus time": 0, "Break time": 0])
                    HStack {
                        Text("Focus time")
                        Spacer()
                        Text("\(history["Focus time"]!.toDate())")
                            .foregroundColor(Color(red: 235/255, green: 235/255, blue: 245/255, opacity: 0.6))
                    }
                    HStack {
                        Text("Break time")
                        Spacer()
                        Text("\(history["Break time"]!.toDate())")
                            .foregroundColor(Color(red: 235/255, green: 235/255, blue: 245/255, opacity: 0.6))
                    }
                }
                .listRowInsets(EdgeInsets(top: 21, leading: 16, bottom: 11, trailing: 16))
                .listSectionSeparator(.hidden, edges: .top)
                .headerProminence(.increased)
                .listRowBackground(Color.black.opacity(0))
            }
            .listStyle(.plain)
        }
        .foregroundColor(.white)
        .background(Color(red: 28/255, green: 28/255, blue: 30/255, opacity: 1))
        .onAppear {
            viewModel.updateHistory()
        }
    }
}

struct historyView_Previews: PreviewProvider {
    static var previews: some View {
        historyView(today: Date().getDay())
    }
}
