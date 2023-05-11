//
//  SettingsVew.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

func defaultTime(_ mode: mode) -> Date {
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    switch mode {
    case .Focus:
        dateComponents.minute = 25
        
    case .Break:
        dateComponents.minute = 5
    }
    
    guard let specificDate = calendar.date(from: dateComponents) else { return Date() }
    return specificDate
}

class SettingsData: ObservableObject {
    @Published var FocusTime: Date = UserDefaults.standard.object(forKey: "FocusTime") as? Date ?? defaultTime(.Focus) {
        didSet {
            UserDefaults.standard.set(self.FocusTime, forKey: "FocusTime")
        }
    }
    
    @Published var currentTime: Date = UserDefaults.standard.object(forKey: "FocusTime") as? Date ?? defaultTime(.Focus) {
        didSet {
            UserDefaults.standard.set(self.FocusTime, forKey: "FocusTime")
        }
    }
    
    @Published var BreakTime: Date = UserDefaults.standard.object(forKey: "BreakTime") as? Date ?? defaultTime(.Break) {
        didSet {
            UserDefaults.standard.set(self.BreakTime, forKey: "BreakTime")
        }
    }
}

struct SettingsVew: View {
    @ObservedObject var settingsTime: SettingsData
    var body: some View {
        VStack {
            Text("Settings")
                .fontWeight(.bold)
                .padding(.bottom, 26)
            
            timeRow(time: $settingsTime.FocusTime, mode: "FocusTime")
            timeRow(time: $settingsTime.BreakTime, mode: "BreakTime")
            
            Spacer()
        }
        .onDisappear {
            settingsTime.currentTime = settingsTime.FocusTime
        }
        .foregroundColor(.white)
        .background(Color(red: 28/255, green: 28/255, blue: 30/255, opacity: 1))
    }
}

struct timeRow: View {
    @Binding var time: Date
    var mode: String
    
    var body: some View {
        HStack {
            DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                Text(mode)
            }
            .environment(\.locale, Locale(identifier: "ru_RU"))
        }
        .padding(16)
        
        Divider()
            .background(Color(red: 56/255, green: 56/255, blue: 58/255))
    }
}

//struct SettingsVew_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsVew()
//    }
//}
