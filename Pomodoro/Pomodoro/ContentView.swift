//
//  ContentView.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State var timer: Timer?
    @State var isPlaying: Bool = false
    @State private var selectedTab = 1
    @State private var showActionSheet = false
    @StateObject var settingsTime = SettingsData()
    
    init(progress: Double) {
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    var body: some View {
        TabView {
            ZStack(alignment: .bottom) {
                Image("BG")
                    .padding(.top, 36)
                
                VStack(spacing: 53) {
                    focusCategory {
                        showActionSheet = true
                    }
                
                    Clock(time: settingsTime)
                    
                    Buttons(isPlaying: $isPlaying)
                    Spacer()
                }
                .padding(.top, 164)
                
                ActionSheet {
                    showActionSheet = false
                }
                    .offset(y: showActionSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onAppear {
                isPlaying ? updateTimer() : stopTimer()
            }
            .onChange(of: isPlaying, perform: { newValue in
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
            
            historyView()
                .tabItem({
                  tabElement(imageName: "file", text: "History")
                })
        }
        .tint(.white)
    }
    
    func updateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            settingsTime.FocusTime = settingsTime.FocusTime.addingTimeInterval(-1)
        }
    }
    func stopTimer() {
        timer?.invalidate()
    }
}

func dateToString(date: Date) -> String {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    let formatter = DateFormatter()
    formatter.dateFormat = hour == 0 ? "mm:ss" : "HH:mm:ss"
    let stringFormat = formatter.string(from: date)
    return stringFormat
}

struct getDate: View {
    @ObservedObject var date: SettingsData
    var body: some View {
        var stringFormat = dateToString(date: date.FocusTime)
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
    @Binding var isPlaying: Bool
    var body: some View {
        HStack(spacing: 80) {
            playOrStop(imageName: isPlaying ? "pause" : "play") {
                isPlaying.toggle()
            }
            playOrStop(imageName: "stop.fill")
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
}

func calculatePercentage(bigDate: Date, smallDate: Date) -> Float {
    return Float(smallDate.getSeconds()) / Float(bigDate.getSeconds())
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
    @ObservedObject var time: SettingsData
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 6)
                .frame(width: 248, height: 248)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(calculatePercentage(bigDate: time.FocusTime, smallDate: time.BreakTime), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 243, height: 243)
            
            VStack {
                getDate(date: time)
                    .font(.system(size: 44))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("Focus on your task")
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
