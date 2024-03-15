//
//  ContentView.swift
//  TrackIt
//
//  Created by Carina Chan on 2/27/24.
//


/*//Old code
import SwiftUI

struct Welcome_TrackIt: View {
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
                        .position(x:110, y:60)
                }
                .frame(width:200, height:70)
            }
        }
    }
}

struct Welcome_TrackIt_Previews: PreviewProvider {
    static var previews: some View {
        Welcome_TrackIt()
    }
}
//Old code*/

import SwiftUI

struct Welcome_TrackIt : View {
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Image("TrackItLogo")
                .resizable()
                .scaledToFit()
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Perform login action
                print("Username: \(username), Password: \(password)")
            }) {
                Text("Login")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationBarTitle("Login")
    }
}

struct Welcome_TrackIt_Previews: PreviewProvider {
    static var previews: some View {
        Welcome_TrackIt()
    }
}

//#Preview {
//    Welcome_TrackIt()
//}
