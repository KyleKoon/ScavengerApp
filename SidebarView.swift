//
//  SidebarView.swift
//  Scavenger App
//
//  Created by Ajay Moturi on 10/23/21.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Activities")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            
            HStack {
                Image(systemName: "chart.bar")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Leaderboard")
                    .foregroundColor(.gray)
                    .font(.headline)
            }

            .padding(.top, 30)

            HStack {
               Image(systemName: "calendar")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Daily Summary")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Friends")
                    .foregroundColor(.gray)
                    .font(.headline)
                
            }
            .padding(.top, 30)
            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Inbox")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
        .ignoresSafeArea(.all)
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
