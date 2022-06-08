    //
    //  ContentView.swift
    //  RiveAnimations
    //
    //  Created by IACD-013 on 2022/06/05.
    //

import SwiftUI
import RiveRuntime

struct ContentView: View {
        //we could use binding
        ///Using Appstorage saves the state on the app storage memory
    @AppStorage("selectedTab") var selected : Tab = .chat
    
    @State var isOpen = false
    @State var isDarkMode = false
    
    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine",autoPlay: false, animationName: "open")
    
    var body: some View {
        ZStack {
            Color(isDarkMode ? "Background 2" : "Background").ignoresSafeArea()
            SideMenu(isDarkMode: $isDarkMode)
                .opacity(isOpen ? 1 : 0)
                .offset(x: isOpen ? 0 : -300)
                .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
            Group{
                    //Switching between views using a switch statement and a tabbar
                switch selected {
                case .chat:
                    HomeView(isDarkMode: $isDarkMode)
                case .search:
                    Text("S")
                case .timer:
                    Text("T")
                case .bell:
                    Text("B")
                case .user:
                    OnboardingView()
                }
            }
            ///Adds a buffer area that resembles a margin to the safe area
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height:80)
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height:104)
            }
            //MARK: Side menu effect
            /// adding the  `isOpen ?` creates the transition between state we want
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(.degrees(isOpen ? 30: 0), axis: (x: 0, y: -1, z: 0))
            .offset(x: isOpen ? 265 : 0)
            .scaleEffect(isOpen ? 0.8 : 1)
            .ignoresSafeArea()
            button.view()
                .frame(width: 44, height: 44)
                .mask(Circle())
                .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0) // moves the icon when opening the side menu
                .onTapGesture {
                    try? button.setInput("isOpen", value: isOpen)
                    ///Wrapping the toggle in an animation carries over to where the toggle is used as a conditional statement
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        isOpen.toggle()
                    }
                }
            
            TabBar(isDarkMode: $isDarkMode)
                .offset(y:isOpen ? 300 : 0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
