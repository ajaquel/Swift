//
//  EventsListView.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI
import CloudKit

struct EventsListView: View {
    
    //new1
    @StateObject private var vm: ItemListViewModel
    
    @State private var title: String = ""
    @State private var type: String = ""
    @State private var description: String = ""
//    @State private var date: Date
    @State private var price: String = ""

    
    init(vm: ItemListViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    func deleteItem( _ indexSet: IndexSet) {
        indexSet.forEach { index in
            let item = vm.items[index]
            if let recordId = item.recordId {
                vm.deleteItem(recordId)
            }
        }
    }
    //new1
    
    
    
    var body: some View {
//        ScrollView {
        VStack {
//            Text("Events List View")
//                .fontWeight(.thin)
//                .padding()
//                .font(.largeTitle)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
//                .foregroundColor(.white)
//
//            Spacer()
            
            Text("Events List")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
//            //new2
            TextField("Event Title", text: $title).textFieldStyle(.roundedBorder)
            TextField("Event Type", text: $type).textFieldStyle(.roundedBorder)
            TextField("Event Description", text: $description).textFieldStyle(.roundedBorder)
//            Date("Event Date", text: $date).formatStyle(
            TextField("Event Price", text: $price).textFieldStyle(.roundedBorder)



            Button("Save") {

                guard let price = try? Decimal(price, format: .number) else {return}

                vm.saveItem(
                    title: title,
                    type: type,
                    description: description,
//                    date: date,
                    price: price)

                self.title = ""
                self.type = ""
                self.description = ""
//                self.date = ""
                self.price = ""

            }.disabled(
                title.trimmingCharacters(in: .whitespaces).isEmpty ||
                type.trimmingCharacters(in: .whitespaces).isEmpty ||
                description.trimmingCharacters(in: .whitespaces).isEmpty ||
//                date.trimmingCharacters(in: .whitespaces).isEmpty ||
                price.trimmingCharacters(in: .whitespaces).isEmpty)

            Spacer()  // Move the text boxes up (How? Weird)
            
            HStack {
                Text("Title")
                Spacer()
                Text("Type")
                Spacer()
                Text("Description")
                Spacer()
                Text("Price")

            }.padding()

            
            List {
                ForEach(vm.items, id: \.recordId) { item in
                    HStack {
                        Text(item.title)
                        Spacer()
                        Text(item.type)
                        Spacer()
                        Text(item.description)
                        Spacer()
//                        Date(item.date)
//                        Spacer()
                        Text("$" + String(describing: item.price))
                    }
                }.onDelete(perform: deleteItem)
            }
            .listStyle(.plain)
            .refreshable { vm.populateItems() }

//            .navigationTitle("Event List")
            //new2
            
        }
//        .padding()   // Add margin for the text boxes.
        .onAppear { vm.populateItems() }
//        }
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
//        EventsListView()
        EventsListView(vm: ItemListViewModel(container: CKContainer.default()))
    }
}
