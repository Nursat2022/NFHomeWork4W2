//
//  ContentView.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    var progress: Double
    @State private var isPlaying: Bool = false
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
                    HStack {
                        Image("Pencil")
                        
                        Text("Focus Category")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 170, height: 36)
                    .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.3))
                    .cornerRadius(20)
                    //                    .padding(.top, 164)
                    
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
                            Text("25:00")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Text("Focus on your task")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    HStack(spacing: 80) {
                        Button(action: {
                            self.isPlaying.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(.white.opacity(0.3))
                                
                                Image(isPlaying ? "play1" : "Union")
                            }
                        }
                        .frame(width: 56, height: 56)
                        
                        Button(action: {}) {
                            ZStack {
                                Circle()
                                    .fill(.white.opacity(0.3))
                                Image("Square")
                            }
                        }
                        .frame(width: 56, height: 56)
                    }
                    Spacer()
                }
                .padding(.top, 164)
            }
            .tabItem({
                VStack {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                        Image("homeHeart")
                            .frame(width: 17, height: 17)
                    }
                    Text("Main")
                        .font(.system(size: 10))
                }
            })
            
            SettingsVew()
                .tabItem({
                    VStack {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 30, height: 30)
                            Image("Settings")
                                .frame(width: 17, height: 17)
                        }
                        Text("Settings")
                            .font(.system(size: 10))
                    }
                })
            
            historyView()
                .tabItem({
                    VStack {
                        ZStack {
                            Image(systemName: "circle")
                                .foregroundColor(.black)
                                .opacity(1)
                            Image("Group1")
                                .frame(width: 17, height: 17)
                        }
                        Text("History")
                            .font(.system(size: 10))
                    }
//                    Image(systemName: "circle")
//                        .renderingMode(.template)
//                        .imageScale(.large)
//                    Text("History")
//                        .background(Color.clear)
                })
//                .background(Color.white)
            
            //            .edgesIgnoringSafeArea(.all)
        }
        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(progress: 0.3)
    }
}
