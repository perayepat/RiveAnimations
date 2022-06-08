    //
    //  SideMenu.swift
    //  RiveAnimations
    //
    //  Created by IACD-013 on 2022/06/07.
    //

import SwiftUI
import RiveRuntime

struct SideMenu: View {
    @State var selectedMenu: SelectedMenu = .home //allows us to choose
    @Binding var isDarkMode: Bool
    let icon = RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity",artboardName: "HOME")
    var body: some View {
        VStack {
            
            HStack {
                    ///Top Section
                Image(systemName: "person")
                    .padding(12)
                    .background(.white.opacity(0.2))
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 2){
                    Text("Name")
                        .customFont(.body)
                    Text("Role")
                        .customFont(.subheadline)
                        .opacity(0.7) // opacity adapts better sometimes
                }
                Spacer()
            }
            .padding()
                ///giving each element a frame and and aligning each of them that way is a way of aligning elements better
            Text("BROWSE")
                .customFont(.subheadline2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)
            
            VStack(alignment: .leading, spacing: 0) {
                    ///Repeating row elements
                ForEach(menuItems) { item in
                        ///divider in each row
                    Rectangle()
                        .frame(height:1)
                        .opacity(0.1)
                        .padding(.horizontal)
                    MenuRow(item: item,selectedMenu: $selectedMenu,isDarkMode: $isDarkMode)
                }
            }
            .padding(8)
            
            Text("HISTORY")
                .customFont(.subheadline2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)
            
            VStack(alignment: .leading, spacing: 0) {
                    ///Repeating row elements
                ForEach(menuItems2) { item in
                        ///divider in each row
                    Rectangle()
                        .frame(height:1)
                        .opacity(0.1)
                        .padding(.horizontal)
                    MenuRow(item: item,selectedMenu: $selectedMenu, isDarkMode: $isDarkMode)
                }
            }
        
            
            .padding(8)
            Spacer()
            
            HStack {
                menuItems3[0].icon.view()
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                    .onChange(of: isDarkMode) { newValue in
                        if newValue {
                            try? menuItems3[0].icon.setInput("active", value: true)
                        } else {
                            try? menuItems3[0].icon.setInput("active", value: false)
                        }
                    }
                Text(menuItems3[0].text)
                    .customFont(.headline)
                Toggle("", isOn: $isDarkMode)
            }
            .padding(20)
        }
        .foregroundColor(isDarkMode ? .white : .black)
        .frame(maxWidth:288, maxHeight: .infinity)
        .background(isDarkMode ? Color(hex: "17203A"):Color(hex: "#A8A8A6"))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(isDarkMode: .constant(false))
    }
}

    ///settingn the data model
struct MenuItem: Identifiable{
    var id = UUID()
    var text: String
    var icon: RiveViewModel
    var menu: SelectedMenu
}

var menuItems = [
    MenuItem(text: "Home", icon: RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME"), menu: .home),
    MenuItem(text: "Search", icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), menu: .search),
    MenuItem(text: "Favorites", icon: RiveViewModel(fileName: "icons", stateMachineName: "STAR_Interactivity", artboardName: "LIKE/STAR"), menu: .favorites),
    MenuItem(text: "Help", icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), menu: .help)
]

var menuItems2 = [
    MenuItem(text: "History", icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), menu: .history),
    MenuItem(text: "Notifications", icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), menu: .notifications)
]

var menuItems3 = [
    MenuItem(text: "Dark Mode", icon: RiveViewModel(fileName: "icons", stateMachineName: "SETTINGS_Interactivity", artboardName: "SETTINGS"), menu: .darkmode)
]

    //setting the selection
enum SelectedMenu: String{
    case home
    case search
    case favorites
    case help
    case history
    case notifications
    case darkmode
    
}
