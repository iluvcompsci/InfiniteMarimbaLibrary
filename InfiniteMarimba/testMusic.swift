//
//  testMusic.swift
//  InfiniteMarimba
//
//  Created by Bri Chapman on 19/01/16.
//  Copyright © 2016 com.bchapman. All rights reserved.
//

import XCTest

class testMusic: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNextNote(){
        let infiniteMarimba = InfiniteMusic()
        var i = 0
        while i < 10 {
            let note = infiniteMarimba.nextMelodyNote()
            infiniteMarimba.playNote(note)
            i = i+1
        }
    }
    

}
