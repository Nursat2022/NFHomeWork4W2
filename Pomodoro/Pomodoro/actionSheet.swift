//
//  actionSheet.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 06.04.2023.
//

import SwiftUI

struct actionSheet: View {
    var progress: Double
    @State private var selectedTab = 1
    
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
                            Text("24:32")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Text("Focus on your task")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 164)
                
                Color.black.opacity(0.2)
                
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .frame(height: 362)
                        
                        VStack {

                            HStack {
                                Spacer()
                                Text("Focus Category")
                                    .fontWeight(.semibold)
                                    .padding(.leading, 35)
                                Spacer()
                                Button(action: {}){
                                    Image("xmark")
                                        .padding(.trailing, 22)
                                }
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 40)
                            
                            VStack(spacing: 20) {
                                HStack(spacing: 14) {
                                    
                                    Button(action: {}) {
                                        Text("Work")
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 170, height: 62)
                                    .background(Color(red: 234/255, green: 234/255, blue: 234/255))
                                    .cornerRadius(16)
                                    .fontWeight(.semibold)
                                    
                                    
                                    Button(action: {}) {
                                        Text("Study")
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 170, height: 62)
                                    .background(Color(red: 234/255, green: 234/255, blue: 234/255))
                                    .cornerRadius(16)
                                    .fontWeight(.semibold)
                                }
                                
                                
                                HStack(spacing: 14) {
                                    Button(action: {}) {
                                        Text("Workout")
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 170, height: 62)
                                    .background(Color(red: 47/255, green: 47/255, blue: 51/255))
                                    .cornerRadius(16)
                                    .fontWeight(.semibold)
                        
                                    Button(action: {}) {
                                        Text("Reading")
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 170, height: 62)
                                    .background(Color(red: 234/255, green: 234/255, blue: 234/255))
                                    .cornerRadius(16)
                                    .fontWeight(.semibold)
                                }
                                
                                HStack(spacing: 14) {
                                    Button(action: {}) {
                                        Text("Meditation")
                                            .foregroundColor(.black)
                                    }
                                        .frame(width: 170, height: 62)
                                        .background(Color(red: 234/255, green: 234/255, blue: 234/255))
                                        .cornerRadius(16)
                                        .fontWeight(.semibold)
                                        
                                    
                                    Button(action: {}) {
                                        Text("Others")
                                            .foregroundColor(.black)
                                    }
                                        .frame(width: 170, height: 62)
                                        .background(Color(red: 234/255, green: 234/255, blue: 234/255))
                                        .cornerRadius(16)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .padding(.bottom, 58)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .tint(.white)
    }
}

struct actionSheet_Previews: PreviewProvider {
    static var previews: some View {
        actionSheet(progress: 0.2)
    }
}
