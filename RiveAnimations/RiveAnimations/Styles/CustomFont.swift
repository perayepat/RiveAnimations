//
//  CustomFont.swift
//  RiveAnimations
//
//  Created by IACD-013 on 2022/06/05.
//

import Foundation
import SwiftUI


struct CustomFont: ViewModifier {
    var textStyle: TextStyle
    
    var name: String {
        switch textStyle {
        case .largeTitle, .title, .title2, .title3:
            return "Poppins Bold"
        case .body, .subheadline, .footnote, .caption:
            return "Inter Regular"
        case .headline, .subheadline2, .footnote2, .caption2:
            return "Inter SemiBold"
        }
    }
    
    var size: CGFloat {
        switch textStyle {
        case .largeTitle:
            return 34
        case .title:
            return 28
        case .title2:
            return 24
        case .title3:
            return 20
        case .body:
            return 17
        case .headline:
            return 17
        case .subheadline:
            return 15
        case .subheadline2:
            return 15
        case .footnote:
            return 13
        case .footnote2:
            return 13
        case .caption:
            return 12
        case .caption2:
            return 12
        }
    }
    
    var relative: Font.TextStyle {
        switch textStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .body:
            return .body
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .subheadline2:
            return .subheadline
        case .footnote:
            return .footnote
        case .footnote2:
            return .footnote
        case .caption:
            return .caption
        case .caption2:
            return .caption
        }
    }
    
    func body(content: Content) -> some View {
        content.font(.custom(name, size: size, relativeTo: relative))
    }
}

extension View {
    func customFont(_ textStyle: TextStyle) -> some View {
        modifier(CustomFont(textStyle: textStyle))
    }
}

enum TextStyle {
    case largeTitle
    case title
    case title2
    case title3
    case body
    case headline
    case subheadline
    case subheadline2
    case footnote
    case footnote2
    case caption
    case caption2
}


//
///// Setting up the custom font to be used more nativley
//struct CustomFont: ViewModifier{
//    var textStyle: TextStyle
//
//    ///Making the `font` call customizable
//    var name: String{
//        switch textStyle {
//        case .title:
//            return "Poppins Bold"
//        case .body:
//            return "Inter Regular"
//        }
//    }
//
//    var size:CGFloat{
//        switch textStyle {
//        case .title:
//            return 28
//        case .body:
//            return 17
//        }
//    }
//
//    var relative:Font.TextStyle{
//        switch textStyle {
//        case .title:
//            return .title
//        case .body:
//            return .body
//        }
//    }
//
//    func body(content: Content) -> some View {
//        content.font(.custom(name, size: size, relativeTo: relative))
//    }
//
//}
//
//
/////Results in `.customFont` while using it in another view
/////Now results in `   .customFont(textStyle: .body)` in use
//extension View{
//    func customFont(_ textStyle: TextStyle) -> some View{
//        modifier(CustomFont(textStyle: textStyle))
//    }
//}
//
//enum TextStyle{
//    case title
//    case body
//}
