//
//  SettingsVew.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

struct SettingsVew: View {
    var focusTime = "25:00"
    var breakTime = "05:00"
    var body: some View {
        VStack {
            Text("Settings")
                .fontWeight(.bold)
                .padding(.bottom, 26)
            
            timeRow(time: focusTime, mode: "FocusTime")
            timeRow(time: breakTime, mode: "BreakTime")
            
            Spacer()
        }
        .foregroundColor(.white)
        .background(Color(red: 28/255, green: 28/255, blue: 30/255, opacity: 1))
    }
}

struct SettingsVew_Previews: PreviewProvider {
    static var previews: some View {
        SettingsVew()
    }
}
