//
//  Test.swift
//  Pomodoro
//
//  Created by Nursat Sakyshev on 08.04.2023.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ZStack {
            Color.red
            Circle()
                .fill(.black)
                .frame(width: 30, height: 30)
            Image("homeHeart")
                .foregroundColor(.red)
        }
        .ignoresSafeArea()
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
