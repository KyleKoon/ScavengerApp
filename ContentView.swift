//
//  ContentView.swift
//  Scavenger App
//
//  Created by Ajay Moturi on 10/22/21.
//
import MapKit
import SwiftUI

struct ContentView: View {
    @State var showSidebar = false
    @State var showMenu = false
    @State var closeMenu = true
   
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapDefaults.latitude, longitude: MapDefaults.longitude),
        span: MKCoordinateSpan(latitudeDelta: MapDefaults.zoom, longitudeDelta: MapDefaults.zoom))

    private enum MapDefaults {
        static let latitude = 45.872
        static let longitude = -1.248
        static let zoom = 0.5
    }
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showSidebar = false
                    }
                }
            }
        
        return GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    VStack {
                        Text("Latitude: \(region.center.latitude), Longitude: \(region.center.longitude). Zoom: \(region.span.latitudeDelta)")
                        .font(.caption)
                        .padding()
                        Map(coordinateRegion: $region,
                            interactionModes: .all,
                            showsUserLocation: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea()
                    }
                    
                    MainView(showSidebar: self.$showSidebar)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x : self.showSidebar ? geometry.size.width/2 : 0)
                        //.disabled(self.showSidebar ? true : false)
                    if self.showSidebar {
                        SidebarView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                    
                    SecondaryView(showMenu: self.showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu {
                        MenuView(closeMenu: self.closeMenu)
                            .transition(.move(edge: .leading))
                    }
                    
                }
                .gesture(drag)
        }
    
}

struct MainView: View {
    
    @Binding var showSidebar: Bool
    
    var body: some View {
        Button {
            withAnimation {
                self.showSidebar = !self.showSidebar
            }
            print("Open the sidebar")
        } label: {
            HStack {
                Image(systemName: "line.3.horizontal.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 550)
                    .padding(.leading, 20)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct SecondaryView: View {
    
    @State var showMenu: Bool = false
    
    var body: some View {
        Button {
            withAnimation {
                self.showMenu = !self.showMenu
            }
            print("Open the menu")
        } label: {
            HStack {
                VStack {
                    Spacer()
                    Image(systemName: "chevron.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}

