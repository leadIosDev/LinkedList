//
//  ContentView.swift
//  LinkedListImplementation
//
//  Created by Shashank on 12/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                self.test()
            }
    }
    
    func test() {
        var list = LinkedList<Int>()
        list.append(value: 1)
        list.append(value: 3)
        list.append(value: 2)
        list.append(value: 4)
        list.append(value: 5)
        list.append(value: 6)

        //print(list)
        //list.removeLast()

        for item in list {
            print(item)
        }
        print(list.last as Any)
        print(list.first as Any)
        print(list.reversed().map({$0}))
        //print(list)
        //list.pop()
        //print(list)
        //list.remove(after: list.node(at: 0)!)
        //print(list)
        //print(list[1].value)
        list[1] = 10
        print(list)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
