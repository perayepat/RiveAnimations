    //
    //  TabBar.swift
    //  RiveAnimations
    //
    //  Created by IACD-013 on 2022/06/06.
    //

import SwiftUI
import RiveRuntime

struct TabBar: View {
    
    ///syncornizing the tab bar var with the one in the content view 
    @AppStorage("selectedTab") var selectedTab: Tab = .chat
        ///playing the animation, needs to be declared as an asset
    let icon =     RiveViewModel(fileName:"icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT")
    
    @Binding var isDarkMode: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack {
                content
            }
            .padding(12)
            .background(Color( isDarkMode ? "Background 2":"Background 3").opacity(0.8))
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: Color("Background 2").opacity(0.3), radius: 20, x: 0, y: 20)
            .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing)))
            .padding(.horizontal,24)
            
        }
    }
    
    var content: some View{
        ForEach(tabItems){item in
            Button{
                try? item.icon.setInput("active", value: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    try? item.icon.setInput("active", value: false)
                }
                    ///change the tab bar selection when the item has been checked
                withAnimation {
                    selectedTab = item.tab
                }
            } label: {
                item.icon.view()
                    .frame( height: 36)
                    .opacity(selectedTab == item.tab ? 1 : 0.6)
                
                    ///line above the selected view
                    .background(
                        VStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.accentColor)
                                .frame(width: selectedTab == item.tab ? 20 : 0, height: 4)
                                .offset(y: -4)
                                // show the item above the selected tab
                                .opacity(selectedTab == item.tab ? 1:0)
                            Spacer()
                        }
                    )
            }
            
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(isDarkMode: .constant(false))
    }
}

    ///Creating a data model for the tab items
struct TabItem: Identifiable{
    var id = UUID()
    var icon: RiveViewModel
    var tab: Tab
}

    // setting the data
var tabItems = [
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), tab: .chat),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), tab: .search),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), tab: .timer),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), tab: .bell),
    TabItem(icon: RiveViewModel(fileName: "icons", stateMachineName: "USER_Interactivity", artboardName: "USER"), tab: .user)
]

    //Tab bar selection
enum Tab: String{
    case chat
    case search
    case timer
    case bell
    case user
}
