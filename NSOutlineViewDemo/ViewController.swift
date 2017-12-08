//
//  ViewController.swift
//  NSOutlineViewDemo
//
//  Created by sycf_ios on 2017/12/8.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa
let PASTEBOARD_TYPE = "com.sb.demo"
class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
//    static let fileManager = FileManager()
//    static let requiredAttributes: Set = [URLResourceKey.isDirectoryKey]
//    static let options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles,
//                                                                   .skipsPackageDescendants,
//                                                                   .skipsSubdirectoryDescendants]
//    lazy var children: = <#expression#>
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    var folderImage = NSWorkspace.shared.icon(forFileType: NSFileTypeForHFSTypeCode(OSType(kGenericFolderIcon)))
    var itemImage = NSWorkspace.shared.icon(forFileType: NSFileTypeForHFSTypeCode(OSType(kGenericDocumentIcon)))
    
    
    var testData = TestData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        folderImage.size = NSSize(width: 28, height: 28)
//        itemImage.size = NSSize(width: 28, height: 28)
        outlineView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: PASTEBOARD_TYPE)])
    }
    //NSOutlineViewDelegate
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let cell = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "cell"), owner: self) as! CustomCellView
        if let folderItem = item as? FolderItem {
            cell.txtField.stringValue = folderItem.name
            cell.imgView.image = folderImage
        }else if let aItem = item as? TestItem {
            cell.txtField.stringValue = aItem.name
            cell.imgView.image = itemImage
        }
        return cell
    }
    //NSOutlineViewDataSource
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return testData.items.count
        }else if let folderItem = item as? FolderItem {
            return folderItem.items.count
        }
        return 0
    }
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return testData.items[index]
        }else if let folderItem = item as? FolderItem {
            return folderItem.items[index]
        }
        return "BAD ITEM"
    }
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return (item is FolderItem)
    }
//    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
//        if let item = item as? BaseItem {
//            return item.name
//        }
//        return "?????"
//    }
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 34
    }
    //Mark: Drag & Drop
}

