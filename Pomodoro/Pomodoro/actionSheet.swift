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
    @State private var isPlaying = false
    
    var body: some View {
        TabView {
            ZStack(alignment: .top) {
                Image("BG")
                    .padding(.top, 36)
                
                VStack(spacing: 53) {
                    focusCategory()
                    
                    Clock(progress: progress, time: "24:32")
                    
                    Buttons(isPlaying: isPlaying)
                    
//                    Spacer()
                }
                .padding(.top, 164)
                
                Color.black.opacity(0.2)
                
                Pomodoro.sheet()
                
            }
        }
        .tint(.white)
    }
}

struct sheet: View {
    var body: some View {
       VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(height: 362)
                
                VStack {
                  head
                    
                    VStack(spacing: 20) {

                        HStack(spacing: 14) {
                          sheetButton(text: "Work", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255))
                            
                            sheetButton(text: "Study", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255))
                        }
                        
                        HStack(spacing: 14) {
                            sheetButton(text: "Wokout", backgroundColor: Color(red: 47/255, green: 47/255, blue: 51/255), textColor: .white)
                
                            sheetButton(text: "Reading", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255))
                        }
                        
                        HStack(spacing: 14) {
                            sheetButton(text: "Meditation", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255))
                                
                            
                            sheetButton(text: "Others", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255))
                        }
                    }
                }
                .padding(.bottom, 58)
            }
        }
    }
    
    var head: some View {
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
    }
}

struct sheetButton: View {
    var text: String
    var backgroundColor: Color
    var textColor: Color = .black
    
    var body: some View {
        Button(action: {}) {
            Text(text)
                .foregroundColor(textColor)
                .frame(width: 170, height: 62)
        }
        .background(backgroundColor)
        .cornerRadius(16)
        .fontWeight(.semibold)
    }
}

struct actionSheet_Previews: PreviewProvider {
    static var previews: some View {
        actionSheet(progress: 0.2)
    }
}
