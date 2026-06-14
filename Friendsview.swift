//
//  ContentView.swift
//  upnout
//
//  Created by Hermela Benyam on 4/1/25.
//

import SwiftUI

struct CloudText: View {
    var text: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            // SF Symbol cloud as the background (white cloud)
            Image(systemName: "cloud.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .frame(width: width, height: height)
                // Optionally add a shadow for extra pop
                .shadow(color: .gray, radius: 3, x: 0, y: 2)
            // Text in the center
            Text(text)
                .font(.title2)
                .bold()
                .foregroundColor(.black)
        }
    }
}


struct ContentView: View {
    @State private var moveUp = false
    @State private var moveUp1 = false
    @State private var moveUp2 = false
    @State private var moveUp3 = false
    
    
    @State private var flyOut1 = false
    @State private var flyOut2 = false
    @State private var flyOut3 = false
    @State private var showMainContent = false

    var body: some View {
        
        //BACKGROUND
        NavigationStack{
            
            
            ZStack{
                
                //MAIN CONTENT SCREEN
                if showMainContent{
                    Color(red: 118/255, green: 157/255, blue: 116/255) // Set the background color
                        .ignoresSafeArea()
                    
                    Image("logo_w_tree")
                        .resizable()
                        .frame(width: 500, height: 600)
                        .offset(x:0, y: 125)
                    //.frame(width: 100, height: 100)
                    
                    VStack {
                        //Spacer()
                        
                        HStack {
                            NavigationLink(destination: Leaderboard()){
                                CloudText(text: "Leaderboard", width: 300, height: 125)
                            }

                                //.padding(.bottom, 9)
                            NavigationLink(destination: FriendsView()){
                                CloudText(text: "Friends", width: 250, height: 100)

                            }
                        } // end of Hstack
                        
                        
                        //.padding(.horizontal, 20)
                        //.padding(.top, 50) // Adjust top padding based on safe area
                        
                        Spacer()
                        
                        // Join Quest Button
                        //Button(action: joinQuest)
                        NavigationLink(destination: Quest_view()){
                            CloudText(text: "Join Quest", width: 250, height: 120)
                        }
                        
                        
                        Spacer()
                    }// end of Vstack
                    //Spacer()
                    
                }//end of if
                
                else{
                    
                    //LOGO ANIMATION SCREEN
                    VStack {
                        Spacer()
                        
                        Image("up")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x: flyOut1 ? 500 : -90, y: moveUp1 ? -65 : 450)
                            .animation(.easeInOut(duration: 1.2), value: moveUp1)
                            .animation(.easeInOut(duration: 1.2), value: flyOut1)
                        
                        
                        Image("and")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .offset(x: flyOut2 ? 500 : 0, y: moveUp2 ? -75 : 450)
                            .animation(.easeInOut(duration: 1.2), value: moveUp2)
                            .animation(.easeInOut(duration: 1.2), value: flyOut2)
                        
                        
                        Image("out")
                            .resizable()
                            .frame(width: 125, height: 75)
                            .offset(x: flyOut3 ? 500 : 75, y: moveUp3 ? -75 : 450)
                            .animation(.easeInOut(duration: 1.2), value: moveUp3)
                            .animation(.easeInOut(duration: 1.2), value: flyOut3)
                        
                        
                        Spacer()
                    }//endofvstack
                    
                    //Background Color
                    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Make it fill the whole screen
                    .background(Color(red: 238/255, green: 231/255, blue: 212/255)) // Set the background color
                    .edgesIgnoringSafeArea(.all)
                    
                    //Appears as user opens app
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            moveUp1 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            moveUp2 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                            moveUp3 = true
                        }
                        
                        // Phase 2: Fly out to the right
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            flyOut3 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                            flyOut2 = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
                            flyOut1 = true
                        }
                        // Phase 3: Show new background + main content
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                showMainContent = true
                            }
                        }// end of dispatch queue
                    }//end of appear
                }//end of else
            }// end of Z stack
        }//end of Navigation Stack
            
    }// end of body
            
}//  end of content view
        
        
#Preview {
        ContentView()
}

