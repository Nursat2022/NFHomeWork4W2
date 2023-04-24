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
    @State var isSelected = ""
    var body: some View {
//        ActionSheet()
        Text("hello")
    }
}

struct ActionSheet: View {
    @EnvironmentObject var Items: PomodoroItems
    @State private var selected = "Work"
    var cancelAction: () -> ()
    
//    var buttons: [sheetButton] = [
//        sheetButton(text: "Work", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255)),
//
//          sheetButton(text: "Study", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255)),
//
//        sheetButton(text: "Wokout", backgroundColor: Color(red: 47/255, green: 47/255, blue: 51/255), textColor: .white),
//
//        sheetButton(text: "Reading", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255)),
//
//        sheetButton(text: "Meditation", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255)),
//
//
//        sheetButton(text: "Others", backgroundColor: Color(red: 234/255, green: 234/255, blue: 234/255))
//
//    ]
    
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
                            sheetButton(isSelected: $selected, text: "Work")

                            sheetButton(isSelected: $selected, text: "Study")
                        }

                        HStack(spacing: 14) {
                            sheetButton(isSelected: $selected, text: "Workout")

                            sheetButton(isSelected: $selected, text: "Reading")
                        }

                        HStack(spacing: 14) {
                            sheetButton(isSelected: $selected, text: "Meditation")


                            sheetButton(isSelected: $selected, text: "Others")
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
            Button(action: cancelAction){
                Image("xmark")
                    .padding(.trailing, 22)
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 40)
    }
}

struct sheetButton: View {
    @Binding var isSelected: String
    @EnvironmentObject var Items: PomodoroItems
    var text: String
//    @State var backgroundColor: Color
//    var textColor: Color = .black

    var body: some View {
        Button(action: {
            isSelected = text
            switch text {
            case "Work": Items.backgroundImage = .Work
            case "Workout": Items.backgroundImage = .Workout
            case "Reading": Items.backgroundImage = .Reading
            case "Meditation": Items.backgroundImage = .Meditation
            case "Study": Items.backgroundImage = .Study
            case "Others": Items.backgroundImage = .Others
            default:
                break
            }
            UserDefaults.standard.setValue(Items.backgroundImage.rawValue, forKey: "BackgroundImage")
        }) {
            Text(text)
                .foregroundColor(isSelected == text ? .white : .black)
                .frame(width: 124, height: 28)
        }
        .frame(width: 170, height: 60)
        .background(isSelected == text ? Color(red: 47/255, green: 47/255, blue: 51/255) : Color(red: 234/255, green: 234/255, blue: 234/255))
        .cornerRadius(16)
        .fontWeight(.semibold)
    }
}

struct actionSheet_Previews: PreviewProvider {
    static var previews: some View {
        actionSheet(progress: 0.2)
    }
}
