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
    @Binding var backgroundImage: backgroundMode
    @State private var selected = "Work"
    var cancelAction: () -> ()
    
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
                            sheetButton(isSelected: $selected, backgroundImage: $backgroundImage, text: "Work")

                            sheetButton(isSelected: $selected, backgroundImage: $backgroundImage, text: "Study")
                        }

                        HStack(spacing: 14) {
                            sheetButton(isSelected: $selected, backgroundImage: $backgroundImage, text: "Workout")

                            sheetButton(isSelected: $selected, backgroundImage: $backgroundImage, text: "Reading")
                        }

                        HStack(spacing: 14) {
                            sheetButton(isSelected: $selected, backgroundImage: $backgroundImage, text: "Meditation")


                            sheetButton(isSelected: $selected, backgroundImage: $backgroundImage, text: "Others")
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
    @Binding var backgroundImage: backgroundMode
    var text: String

    var body: some View {
        Button(action: {
            isSelected = text
            switch text {
            case "Work": backgroundImage = .Work
            case "Workout": backgroundImage = .Workout
            case "Reading": backgroundImage = .Reading
            case "Meditation": backgroundImage = .Meditation
            case "Study": backgroundImage = .Study
            case "Others": backgroundImage = .Others
            default:
                break
            }
            UserDefaults.standard.setValue(backgroundImage.rawValue, forKey: "BackgroundImage")
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
