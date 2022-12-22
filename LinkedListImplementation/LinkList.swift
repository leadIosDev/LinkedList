//
//  LinkList.swift
//  LinkedListImplementation
//
//  Created by Shashank on 12/22/22.
//

import Foundation


class Node<Value> {
    var value: Value
    var next: Node<Value>?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard next != nil else {
            return "\(value)"
        }
        return "\(value) -> \(String(describing: next!))"
    }
}

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    var elementCount: Int = 0
    
    var isEmpty: Bool {
        head == nil
    }
    
   mutating func push(value: Value) {
        head =  Node(value: value, next: head)
        if tail == nil {
            self.tail = head
        }
       self.elementCount += 1
    }
    
    mutating func append(value: Value) {
        guard tail != nil else {
            self.push(value: value)
            return
        }
        tail?.next = Node(value: value)
        tail = tail?.next
        self.elementCount += 1
    }
    
    func node(at index: Int) -> Node<Value>? {
        guard !isEmpty else {
            return nil
        }
        var currentNodeIndex = 0
        var currentNode: Node<Value>? = head
        while currentNodeIndex < index && currentNode != nil {
            currentNode = currentNode!.next
            currentNodeIndex += 1
        }
        return currentNode
    }
    
    @discardableResult
    mutating func insert(value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value: value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        self.elementCount += 1
        return node.next!
    }
    
    mutating func pop() -> Value? {
        let currentHead = head
        head = head?.next
        if isEmpty {
            tail = nil
        }
        self.elementCount -= 1
        return currentHead?.value
    }
    
    mutating func removeLast() -> Value? {
        guard !isEmpty else {
            return nil
        }
        if head?.next == nil {
            return pop()
        }
        var current = head
        while current?.next !== tail {
            current = current?.next
        }
        let temp = current?.next
        current?.next = nil
        tail = current
        self.elementCount -= 1
        return temp?.value
    }
    
    mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
            self.elementCount -= 1
        }
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        if isEmpty {
            return "List is empty"
        }
        return String(describing: head!)
    }
}

//MARK: Creating linkedList as a sequence to work with for loop
//
//extension LinkedList: Sequence, IteratorProtocol {
//
//    mutating func next() -> Node<Value>? {
//        defer {
//            head = head?.next
//        }
//        return head
//    }
//}

extension LinkedList: MutableCollection {
    var startIndex: Int {
        return 0
    }
    var endIndex: Int {
        return self.elementCount
    }

    subscript(position: Int) -> Value {
        get {
            precondition(position < endIndex && position >= 0, "index out of bound")
            return self.node(at: position)!.value
        } set(newValue) {
            precondition(position < endIndex && position >= 0, "index out of bound")
            if position == 0 {
                push(value: newValue)
            } else {
                insert(value: newValue, after: node(at: position - 1)!)
            }
        }
    }

    func index(after i: Int) -> Int {
        precondition(i < endIndex, "index out of bound")
        return i + 1
    }
}

extension LinkedList: BidirectionalCollection {
    func index(before i: Int) -> Int {
        precondition(i > 0, "index out of bound")
        return i - 1
    }
}

