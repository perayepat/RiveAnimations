    //
    //  HomeView.swift
    //  RiveAnimations
    //
    //  Created by IACD-013 on 2022/06/07.
    //

import SwiftUI

struct HomeView: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        ZStack {
        //Background
            Color(isDarkMode ? "Background 2" : "Bacground").ignoresSafeArea()
            ///making content scrollable
            ScrollView {
                VStack(alignment:.leading,spacing: 0) {
                    Text("Courses")
                        .customFont(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20){
                            ForEach(courses) { course in
                                VCard(course: course)
                            }
                        }
                        .padding(20)
                        .padding(.bottom, 10)
                    }
                    Text("Recent")
                        .customFont(.title3)
                        .padding(.horizontal, 20)
                    
                    VStack(spacing: 20) {
                        ForEach(courseSections) { sect in
                            HCard(section: sect)
                        }
                    }
                    .padding(20)
                }
                .foregroundColor( isDarkMode ? .white : .black)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isDarkMode: .constant(false))
    }
}


var content: some View {
    VStack(alignment:.leading,spacing: 0) {
        Text("Courses")
            .customFont(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20){
                ForEach(courses) { course in
                    VCard(course: course)
                }
            }
            .padding(20)
            .padding(.bottom, 10)
        }
        Text("Recent")
            .customFont(.title3)
            .padding(.horizontal, 20)
        
        VStack(spacing: 20) {
            ForEach(courseSections) { sect in
                HCard(section: sect)
            }
        }
        .padding(20)
    }
//    .foregroundColor( isDarkMode ? .white : .black)
}

