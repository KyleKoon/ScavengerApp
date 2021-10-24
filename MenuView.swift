//
//  MenuView.swift
//  Scavenger App
//
//  Created by Ajay Moturi on 10/23/21.
//

import SwiftUI

struct MenuView: View {
    @Binding var closeMenu: Bool = false
    var body: some View {
        return GeometryReader { geometry in
        VStack {
            Spacer()
            
            Button {
                closeMenu = true
                print("Close the menu")
            } label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)

            }
            
            MenuView(closeMenu: self.$closeMenu)
                .frame(width: geometry.size.width, height: geometry.size.height)
            if self.closeMenu {
                ContentView()
                .transition(.move(edge: .top))
            }
            
            Spacer()
            
            Text("Account")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .font(.largeTitle)
            Spacer()
            
            Text("Settings")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .font(.largeTitle)
            
            Spacer()
            
            Text("Sign Out")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .font(.largeTitle)
            
            //Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: 211/255, green: 211/255, blue: 211/255))
        .opacity(0.9)
        .ignoresSafeArea()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(closeMenu: .constant(true))
    }
}
