//
//  VCard.swift
//  RiveAnimations
//
//  Created by IACD-013 on 2022/06/07.
//

import SwiftUI

struct VCard: View {
    var course: Course
    
    var body: some View {
        VStack(alignment:.leading, spacing: 8){
            Text(course.title)
                .customFont(.title2)
                .frame(maxWidth: 170, alignment: .leading)
                .layoutPriority(1) /// giving the title more layout priority 
            Text(course.subtitle)
                .customFont(.subheadline)
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading) ///Using the full space of the card
            Text(course.caption.uppercased())
                .customFont(.footnote2)
            
            Spacer()
            //MARK: Radnomised avatars
            HStack {
                ///Wrapped in a array in order to use the index to shift the icons so that you can shift then slightly to the left
                ForEach(Array([4,5,6].shuffled().enumerated()), id: \.offset) {index, item in
                    Image("Avatar \(item)")
                        .resizable()
                        .frame(width: 44, height: 44)
                    .mask(Circle())
                    .offset(x: CGFloat(index * -20))
                }
            }
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(.linearGradient(colors: [course.color, course.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: course.color.opacity(0.5), radius: 8, x: 0, y: 12)
        .shadow(color: course.color.opacity(0.2), radius: 2, x: 0, y: 11)
        .overlay(course.image
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
        )
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
        VCard(course: courses[0])
    }
}
