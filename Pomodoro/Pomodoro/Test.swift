//
//  Test.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 08.04.2023.
//

import SwiftUI

class historyDate {
    var focusTime: Int = 0
    var breakTime: Int = 0
}

struct Test: View {
    var date = Date()
    var data: historyDate = historyDate()
    var body: some View {
        VStack {
            Text("\(date.getSeconds())")
            Text("\(data.focusTime)")
        }
    }
    
    func toStr() -> String {
        let date: Date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        return formatter.string(from: date)
        data.focusTime += date.getSeconds()
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
