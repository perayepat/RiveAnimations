//
//  MenuRow.swift
//  RiveAnimations
//
//  Created by IACD-013 on 2022/06/07.
//

import SwiftUI

struct MenuRow: View {
    var item: MenuItem
    @Binding var selectedMenu: SelectedMenu
    @Binding var isDarkMode:Bool
    
    var body: some View {
        HStack(spacing: 14) {
            item.icon.view()
                .frame(width: 32, height: 32)
                .opacity(0.6)
            Text(item.text)
                .customFont(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.blue)
                .frame(maxWidth: selectedMenu == item.menu ? .infinity : 0)
                .frame(maxWidth: .infinity, alignment: .leading))
        .background(isDarkMode ? Color("Background 2") : Color("Background 3"))
        .onTapGesture {
            try?  item.icon.setInput("active", value: true)
                ///stop after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                try?  item.icon.setInput("active", value: false)
            }
            withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) { /// The timing curve helps make the app feel more snappy and responsive
                selectedMenu = item.menu // updating the state to each item from the loop specfic to the menu
            }
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow(item: menuItems[0],selectedMenu: .constant(.home),isDarkMode: .constant(false))
    }
}
