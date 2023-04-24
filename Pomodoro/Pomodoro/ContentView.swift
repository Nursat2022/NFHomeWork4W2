//
//  ContentView.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

enum mode {
    case Focus
    case Break
}

enum backgroundMode: String {
    case Work = "BG"
    case Study = "BG1"
    case Workout = "BG2"
    case Reading = "BG3"
    case Meditation = "BG4"
    case Others = "BG5"
}

struct ContentView: View {
    var today: String
    @State var timerMode: mode = .Focus
    @State var backgroundImage: backgroundMode = backgroundMode(rawValue: (UserDefaults.standard.object(forKey: "BackgroundImage") as? String) ?? "BG")!
    @State var timer: Timer?
    @State var isPlaying: Bool = false
    @State private var selectedTab = 1
    @State private var showActionSheet = false
    @StateObject var settingsTime = SettingsData()
    
    init(progress: Double) {
//        today = Date().getDay()
        today = "25.04.23"
        UITabBar.appearance().unselectedItemTintColor = .white
        var arr: [String] = UserDefaults.standard.object(forKey: "days") as? [String] ?? []
        if !arr.contains(today) {
            arr.append(today)
        }
        UserDefaults.standard.setValue(arr, forKey: "days")
    }
    
    var body: some View {
        TabView {
            ZStack(alignment: .bottom) {
                Image(backgroundImage.rawValue)
                    .padding(.top, 36)
                
                VStack(spacing: 53) {
                    focusCategory {
                        showActionSheet = true
                    }
                
                    Clock(timerMode: $timerMode, time: settingsTime)
                    
                    Buttons(today: today, timerMode: $timerMode, settingsTime: settingsTime, isPlaying: $isPlaying)
                    Spacer()
                }
                .padding(.top, 164)
                
                ActionSheet(backgroundImage: $backgroundImage) {
                    showActionSheet = false
                }
                    .offset(y: showActionSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onAppear {
                isPlaying ? updateTimer() : stopTimer()
            }
            
            .onDisappear {
                stopTimer()
            }
            
            .onChange(of: settingsTime.currentTime, perform: { _ in
                if settingsTime.currentTime.getSeconds() < 1 {
                    var history = UserDefaults.standard.object(forKey: today) as? [String: Int] ?? ["Focus time": 0, "Break time": 0]
                    switch timerMode {
                    case .Focus:
                        history["Focus time"]! += settingsTime.FocusTime.getSeconds()
                        UserDefaults.standard.setValue(history, forKey: today)
                        settingsTime.currentTime = settingsTime.BreakTime
                        timerMode = .Break
                    case .Break:
                        history["Break time"]! += settingsTime.FocusTime.getSeconds()
                        UserDefaults.standard.setValue(history, forKey: today)
                        settingsTime.currentTime = settingsTime.FocusTime
                        timerMode = .Focus
                    }
                }
            })
            .onChange(of: isPlaying, perform: { _ in
                isPlaying ? updateTimer() : stopTimer()
            })
            .animation(.spring(), value: showActionSheet)
            .tabItem({
                tabElement(imageName: "homeHeart", text: "Main")
            })
            
            SettingsVew(settingsTime: settingsTime)
                .tabItem({
                  tabElement(imageName: "Settings", text: "Settings")
                })
            
            historyView(today: today)
                .tabItem({
                  tabElement(imageName: "file", text: "History")
                })
        }
        .tint(.white)
    }
    
    func updateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            settingsTime.currentTime = settingsTime.currentTime.addingTimeInterval(-1)
        }
    }
    func stopTimer() {
        timer?.invalidate()
    }
}

func dateToString(date: Date) -> String {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let formatter = DateFormatter()
    formatter.dateFormat = hour == 0 ? "mm:ss" : "HH:mm:ss"
    let stringFormat = formatter.string(from: date)
    return stringFormat
}

struct getDate: View {
    @ObservedObject var date: SettingsData
    var body: some View {
        let stringFormat = dateToString(date: date.currentTime)
        return Text("\(stringFormat)")
    }
}

struct focusCategory: View {
    var action: () -> ()
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "pencil")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                
                Text("Focus Category")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .frame(width: 170, height: 36)
            .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.3))
            .cornerRadius(20)
        }
    }
}

struct Buttons: View {
    var today: String
    @Binding var timerMode: mode
    @ObservedObject var settingsTime: SettingsData
    @Binding var isPlaying: Bool
    var body: some View {
        HStack(spacing: 80) {
            playOrStop(imageName: isPlaying ? "pause" : "play") {
                isPlaying.toggle()
            }
            playOrStop(imageName: "stop.fill") {
                var historyToday: [String: Int] = UserDefaults.standard.object(forKey: today) as? [String: Int] ?? ["Focus time": 0, "Break time": 0]
                
                var historyToday1: [String: Int] = UserDefaults.standard.object(forKey: "25.04.23") as? [String: Int] ?? ["Focus time": 0, "Break time": 0]
                
                switch timerMode {
                case .Focus:
                    historyToday["Focus time"]! += settingsTime.FocusTime.getSeconds() - settingsTime.currentTime.getSeconds()
                    settingsTime.currentTime = settingsTime.FocusTime
                
                case .Break:
                    historyToday["Break time"]! += settingsTime.BreakTime.getSeconds() - settingsTime.currentTime.getSeconds()
                    settingsTime.currentTime = settingsTime.BreakTime
                }
                print("\(historyToday["Focus time"])", today)
                print("second \(historyToday1["Focus time"])", today)
                UserDefaults.standard.setValue(historyToday, forKey: today)
                isPlaying = false
            }
        }
    }
}

extension Date {
    func getSeconds() -> Int {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let seconds = calendar.component(.second, from: self)
        return hour * 3600 + minutes * 60 + seconds
    }
    
    func getDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        return formatter.string(from: self)
    }
}

extension Int {
    func toDate() -> String {
        let hours = self / 3600
        let minutes = self / 60
        let seconds = self % 60
        return hours == 0 ? String(format: "%02d:%02d", minutes, seconds) :
        String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

func calculatePercentage(bigDate: Date, smallDate: Date) -> Float {
    return Float(bigDate.getSeconds() - smallDate.getSeconds()) / Float(bigDate.getSeconds())
}

struct tabElement: View {
    var imageName: String
    var text: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(imageName)
            }
            Text(text)
                .font(.system(size: 10))
        }
    }
}

struct Clock: View {
    @Binding var timerMode: mode
    @ObservedObject var time: SettingsData
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 6)
                .frame(width: 248, height: 248)
            
                Circle()
                .trim(from: 0.0, to: CGFloat(min(calculatePercentage(bigDate: timerMode == .Focus ? time.FocusTime : time.BreakTime, smallDate: time.currentTime), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 243, height: 243)

            
            VStack {
                getDate(date: time)
                    .font(.system(size: 44))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text(timerMode == .Focus ? "Focus on your task" : "Break")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(progress: 0.0)
    }
}

struct playOrStop: View {
    var imageName: String
    var act: () -> () = {}
    var body: some View {
        Button(action: act) {
            ZStack {
                Circle()
                    .fill(.white.opacity(0.3))
                Image(systemName: imageName)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
            }
        }
        .frame(width: 56, height: 56)
    }
}
