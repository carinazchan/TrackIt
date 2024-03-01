//
//  ContentView.swift
//  TrackIt
//
//  Created by Carina Chan on 2/27/24.
//

import SwiftUI

struct ContentView: View {
    let background = Color("Color_WelcomePageBackground")
    
    var body: some View {
        ZStack {
            Color("Color_WelcomePageBackground").ignoresSafeArea()
            
            VStack {
                
                Image("WelcomePageLady")
                    .resizable()
                    //.cornerRadius(15)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300, alignment: .bottom)
                    .padding(.all)
                    .position(x:210, y:560)

                Image("TrackItLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300, alignment: .bottom)
                    .padding(.all)
                    .position(x:200, y:-80)
                
                Button(action: {
                    // Action to perform when the button is tapped
                    print("Button tapped!")
                }) {
                    Text("Get Started")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        //.cornerRadius(0)
                        .position(x:110, y:60)
                }
                .frame(width:200, height:70)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
