//
//  ContentView.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    var progress: Double
    @State var isPlaying: Bool = false
    @State private var selectedTab = 1
    
    init(progress: Double) {
        self.progress = progress
        UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    var body: some View {
        TabView {
            ZStack {
                Image("BG")
                    .padding(.top, 36)
                
                VStack(spacing: 53) {
                    focusCategory()
                
                    Clock(progress: progress, time: "25:00")
                    
                    Buttons(isPlaying: isPlaying)
                    
                    Spacer()
                }
                .padding(.top, 164)
            }
            .tabItem({
                tabElement(imageName: "homeHeart", text: "Main")
            })
            
            SettingsVew()
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
}

struct focusCategory: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                //                Image("Pencil")
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
    @State var isPlaying: Bool
    var body: some View {
        HStack(spacing: 80) {
            playOrStop(imageName: isPlaying ? "play" : "pause") {
                isPlaying.toggle()
            }
            playOrStop(imageName: "stop")
        }
    }
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
    var progress: Double
    var time: String
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.white.opacity(0.3), lineWidth: 6)
                .frame(width: 248, height: 248)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 243, height: 243)
            
            VStack {
                Text(time)
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
        ContentView(progress: 0.3)
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
