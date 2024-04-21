//
//  main.swift
//  PreventDataRace
//
//  Created by Angelos Staboulis on 21/4/24.
//

import Foundation
var counter = 0
let lock = NSLock()
func incrementCounter(){
    lock.lock()
    counter = counter + 1
    lock.unlock()
}
let dispatch = DispatchQueue(label:"com.template.preventdatarace",attributes: .concurrent)

dispatch.async {
    for _ in stride(from: 0, to: 1000, by: 1){
        incrementCounter()
    }
}
dispatch.async {
    for _ in stride(from: 0, to: 1000, by: 1){
        incrementCounter()
    }
}
dispatch.sync(flags: .barrier) {}
debugPrint(counter)
