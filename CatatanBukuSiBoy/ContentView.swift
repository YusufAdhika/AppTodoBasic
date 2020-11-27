//
//  ContentView.swift
//  CatatanBukuSiBoy
//
//  Created by Mactop78 on 20/11/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Taks.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Taks.taks, ascending: true)])
    var tasks : FetchedResults<Taks>
    
    @State var type = ""
    var body: some View {
        NavigationView{
        VStack{
            List{
                ForEach(tasks){ data in
                    Text(data.taks ?? "Unknown")
                }.onDelete(perform: deleteData)
            }
            HStack{
                TextField("Type Hire", text: $type)
                    .padding()
                Button(action: {
                    let todo = Taks(context: self.moc)
                    todo.taks = self.type
                    todo.id = UUID()
                    
                    try! self.moc.save()
                    
                }, label: {
                    Image(systemName: "plus")
                        .padding()
                })
            }.navigationBarTitle("Catatan Buku SI Boy", displayMode: .inline)
        }
        }
    }

func deleteData(at offset: IndexSet) {
    for index in offset{
        let data = tasks[index]
        moc.delete(data)
        
        try! moc.save()
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
