    //
    //  OnboardingView.swift
    //  RiveAnimations
    //
    //  Created by IACD-013 on 2022/06/05.
    //

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
        /// To run the active animation in rive
    let button = RiveViewModel(fileName: "button")
    @State var showModal = false/// this is bound to the same view in the signin view and
    var body: some View {
        ZStack {
            
            background
            content
                .offset(y: showModal ? -50 : 0)
            Color("Shadow")
                .opacity(showModal ? 0.4 : 0) /// DIm background
                .ignoresSafeArea()
            
            if showModal{
                SigninView(showModal: $showModal)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        Button{
                            withAnimation(.spring()){
                                showModal = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.black)
                                .background(.white)
                                .mask(Circle())
                                .shadow(color: Color("Shadow").opacity(0.5), radius: 5, x: 0, y: 3)
                        }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    )
                    .zIndex(1)
            }
        }
    }
    var content: some View{
        VStack(alignment:.leading, spacing: 16) {
            Text("Learn design & code")
                .font(.custom("Poppins Bold", size: 60, relativeTo: .largeTitle))
                .frame(width: 260, alignment: .leading)
            
            Text("Don't skip Design. Learn design and code, by using React and Swift. Complete courses about the best tools")
                .customFont(.body)
                .opacity(0.7)
                .frame(width: .infinity, alignment: .leading)
            
            Spacer()
            
            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                    Label("Start the course", systemImage: "arrow.forward")
                        .offset(x: 4, y: 4)
                        .font(.headline)
                )
                .background(
                    Color.black
                        .blur(radius: 30)
                        .opacity(0.3)
                        .offset(y: 10)
                )
                ///Allows the animation to play
                .onTapGesture {
                    try? button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                        withAnimation(.spring()){
                            showModal = true
                        }
                    }
                }
            Spacer()
            Text("With and easy payment of nothing but the best cringe on main")
                .customFont(.subheadline)
                .opacity(0.6)
        }
        .padding(40)
        .padding(.top, 40)
    }
    var background: some View{
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 20)
            .background(
                Image("Spline")
                    .blur(radius: 90)
                    .offset(x: 20, y: 100)
                
            )
    }
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
