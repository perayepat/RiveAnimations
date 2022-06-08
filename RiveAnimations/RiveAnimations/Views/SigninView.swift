    //
    //  SigninView.swift
    //  RiveAnimations
    //
    //  Created by IACD-013 on 2022/06/05.
    //

import SwiftUI
import RiveRuntime

struct SigninView: View {
    @State var email = ""
    @State var passowrd = ""
    @State var isLoaidng = false
    @Binding var showModal: Bool ///dismiss this modal view in the onboarding view
    let check  = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    
    ///Log in method
    fileprivate func logIn() {
        isLoaidng = true
        
        if email != "" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                try? check.triggerInput("Check")
            }
                // Confetti DispatchQueue
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                isLoaidng = false
                try? confetti.triggerInput("Trigger explosion")
            }
            ///On a successful log in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showModal = false /// Dismiss the modal after 4 seconds
                }
            
            }
        } else {
            //Error animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation{
                    try? check.triggerInput("Error")
                }
            }
            //mkae the error disapppear after this amount of time
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                withAnimation{
                    isLoaidng = false
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Sign In")
                .customFont(.largeTitle)
            Text("Acess to 240+ hours of content. Learn design and code, by building real apps with react and swift")
                .customFont(.subheadline)
            
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $email)
                    .customTextField()
            }
            VStack(alignment: .leading) {
                Text("Passoword")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                SecureField("", text: $passowrd)
                    .customTextField(image: Image("Icon Lock"))
            }
                //MARK: Button with custom rounded corners
            Button{
                logIn()
            } label:{
                Label("Sign In", systemImage: "arrow.right")
                    .customFont(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "F77D8E")) //Using Hex Colors
                    .foregroundColor(.white)
                    .cornerRadius(20,corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8,corners: [.topLeft])
                    .shadow(color: Color(hex: "F77D8E").opacity(0.8), radius: 20, x: 0, y: 10)
            }
            
                //MARK: Custom Divider
            HStack {
                Rectangle().frame(height: 1).opacity(0.1)
                Text("OR")
                    .customFont(.subheadline2)
                    .foregroundColor(.black.opacity(0.3))
                Rectangle().frame(height: 1).opacity(0.1)
            }
            
            
            Text("Sign in with Email, Apple or Google")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            
            HStack{
                Image("Logo Email")
                Spacer()
                Image("Logo Apple")
                Spacer()
                Image("Logo Google")
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous)
            .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding()
        .overlay(
            ZStack{
                if isLoaidng{
                    check.view()
                        .frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                confetti.view()
                    .allowsHitTesting(false)
                    .scaleEffect(2.5)
            }
        )
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView(showModal: .constant(true))
    }
}
