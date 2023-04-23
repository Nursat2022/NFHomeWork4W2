//
//  historyView.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

struct historyView: View {
    var body: some View {
        VStack {
            Text("History")
                .fontWeight(.bold)
                .padding(.bottom, 26)
        
            ScrollView {
                    dates(day: "21.01.21", focusTime: "25:00", breakTime: "05:00")
                    dates(day: "21.03.21", focusTime: "15:00", breakTime: "05:00")
                    dates(day: "21.01.21", focusTime: "34:00", breakTime: "05:00")
            }
            
            Spacer()
        }
        .foregroundColor(.white)
        .background(Color(red: 28/255, green: 28/255, blue: 30/255, opacity: 1))
    }
}

struct dates: View {
    var day: String
    var focusTime: String
    var breakTime: String
    
    var body: some View {
        Section(header: HStack {
            Text(day)
                .font(.system(size: 23))
                .fontWeight(.bold)
            Spacer()
        }.frame(width: 358, height: 26)) {
//            timeRow(time: focusTime, mode: "FocusTime")
//            timeRow(time: breakTime, mode: "BreakTime")
        }
    }
}


struct historyView_Previews: PreviewProvider {
    static var previews: some View {
        historyView()
    }
}
