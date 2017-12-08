//
//  TestData.swift
//  NSOutlineViewDemo
//
//  Created by sycf_ios on 2017/12/8.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Foundation

class BaseItem {
    var name: String = ""
}
class TestItem: BaseItem {
    
}
class FolderItem: BaseItem {
    var items:[TestItem] = []
}
class TestData {
    var items: [BaseItem] = []
    init() {
        for i in 1...5 {
            let item = TestItem()
            item.name = "RootItem.\(i)"
            items.append(item)
        }
        for i in 1...5 {
            let folder = FolderItem()
            folder.name = "Folder.\(i)"
            for j in 1...3 {
                let item = TestItem()
                item.name = folder.name + ".Child.\(j)"
                folder.items.append(item)
            }
            items.append(folder)
        }
        let folder = FolderItem()
        folder.name = "Empty"
        items.append(folder)
    }
}
