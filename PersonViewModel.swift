//
//  PersonViewModel.swift
//  ScavengerAppTest
//
//  Created by Ajay Bati on 10/23/21.
//
import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit

class PersonViewModel: ObservableObject {
    @Published var p: Person = Person(id: "",Total: [:], name: "", location: GeoPoint(latitude: 0, longitude: 0), steps: 0)
    @Published var logged_in = false
    @Published var top = [[String:Int]]()
    @Published var lis = [Person]()
    @Published var regions = [Region]()
    private var db = Firestore.firestore()
    
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
                do {
                    self.p.id = Auth.auth().currentUser!.uid
                    self.p.name = "GT"
                    self.p.location = GeoPoint(latitude: 33.774442713395736, longitude: -84.39646195432165)
                    self.p.steps = 2234
                    self.p.Total = [self.p.name:20]
                    let _ = try self.db.collection("people").document(self.p.id).setData(from: self.p)
                    self.getData()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.logged_in = true
            } else {
                self.p.id = Auth.auth().currentUser!.uid
                self.p.name = "yum"
                self.getData()
                do {
                    try self.db.collection("people").document(self.p.id).setData(from: self.p)
                } catch {
                    print(error)
                }
                print("success")
            }
        }
    }
    
    
    func store_loc(point: CLLocationCoordinate2D) {
        let mapToGeo: GeoPoint = GeoPoint(latitude: point.latitude, longitude: point.longitude)
        self.p.location = mapToGeo
        self.p.name = "yuhhh"
        do {
            try self.db.collection("people").document(self.p.id).setData(from: self.p)
        } catch {
            print(error)
        }
    }
    
//    func fetch_regions() {
//        print("hey")
//        db.collection("Regions").document("Georgia Institute of Technology").getDocument() { (snapshot, err) in
//            if err == nil {
//                if let snapshot = snapshot {
//                    if let data = snapshot.data() {
//                        for reg in data{
//                            let name = reg.key
//                            let location = reg[name]
//                            let name = reg[name]
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    //func fetch_region() -> Region {
        //var current
        //use self.p.location and access:
//        db.collection("Regions").addSnapshotListener { (querySnapshot, error) in
//            guard let doccuments = querySnapshot?.documents else {
//                print("None")
//                return
//            }
//            ITERATE THROUGH DOCUMENTS:
//            for document in documents{
//                if document.location or whtvr near self.p.location
//            }
//
//        }
    
    //}

    
//    func fetch_nearbyRegions() -> [Region] {
//        var regions: [Region] = []
//        //same as above
//    }
    func getData() {
        db.collection("people").getDocuments() { (snapshot, err) in
            if err == nil {
                if let snapshot = snapshot {
                    self.lis = snapshot.documents.compactMap { (queryd) -> Person? in
//                        return Person(id: queryd.documentID, Total: queryd["Total"]["GT"], name: queryd["location_name"], location: queryd["Location"], steps: queryd["steps"])
                        return try? queryd.data(as: Person.self)
                    }
                }
            }
        }
    }
    func top_5() {
        self.getData()
        self.top = [[String: Int]]()
        var t: [String: Int] = [:]
        for a: Person in self.lis {
            if a.name==self.p.name {
                t[a.id] = a.Total["GT"]
            }
        }
        let tm = t.sorted { $0.1 > $1.1 }
        var count = 0
        for(id, score) in tm {
            self.top.append([id:score])
            count = count+1
            if(count == 5) {
                break
            }
        }
        
//        var topf: [String: Int] = [:]
//        db.collection("people").getDocuments() { (querySnapshot, err) in //name = GT in this case
//
//            if let err = err {
//                print("Error getting documents: \(err)")
//                print("hi")
//            } else {
//                for document in querySnapshot!.documents {
//                    let ddata = document.data()
//                    if let d = ddata["Total"] as? [String: Any] {
//                        if let score = d[self.p.name]{
//                            topf[document.documentID] = score as? Int ?? 0
//                        }
//                    }
//                }
//                let sortedByValueDictionary = topf.sorted { $0.1 > $1.1 }
//                print("--")
//                print(sortedByValueDictionary)
//                print("--")
//                var count: Int = 0
//                for(id, score) in sortedByValueDictionary{
//                    self.top.append([id:score])
//                    count = count+1
//                    if(count == 5) {
//                        break
//                    }
//                }
//            }
//        }
    }
    
//    func call_top5() -> [String: Int] {
//        top_5() { (result) in
//            return result
//        }
//    }
}
