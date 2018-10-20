//
//  Static.swift
//  you
//
//  Created by Jun Zhou on 10/19/18.
//  Copyright © 2018 jzhou. All rights reserved.
//

import Foundation
import CoreStore

public struct Static {
    // static let userConfiguration = "Default"
    static let youStack: DataStack = {
        let dataStack = DataStack(xcodeModelName: "you")
        try! dataStack.addStorageAndWait(
            SQLiteStore(
                fileName: "you",
                localStorageOptions: .recreateStoreOnModelMismatch
            )
        )
        return dataStack
    }()
}
