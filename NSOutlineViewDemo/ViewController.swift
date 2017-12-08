//
//  ViewController.swift
//  NSOutlineViewDemo
//
//  Created by sycf_ios on 2017/12/8.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa
let PASTEBOARD_TYPE = "com.sb.demo"
class ViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate,NSPasteboardItemDataProvider {

    
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
        
        // Register for the dropped object types we can accept.
        outlineView.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: PASTEBOARD_TYPE)])
        // Disable dragging items from our view to other applications.
        outlineView.setDraggingSourceOperationMask(NSDragOperation(), forLocal: false)
        // Enable dragging items within and into our view.
        outlineView.setDraggingSourceOperationMask(NSDragOperation.every, forLocal: true)
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
    //此方法可以使剪切板起作用
    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
        let pbItem = NSPasteboardItem()
        pbItem.setDataProvider(self, forTypes: [NSPasteboard.PasteboardType(rawValue: PASTEBOARD_TYPE)])
        return pbItem
    }
    //此方法可以使Drop起作用
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
//        let canDrag = (index >= 0) && (item != nil)
        if index >= 0 && item != nil {
            return .move
        }
        return NSDragOperation()
    }
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
//        let pb = info.draggingPasteboard()
//        let name = pb.string(forType: NSPasteboard.PasteboardType(rawValue: PASTEBOARD_TYPE))
        return true
        
    }
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
        
    }
}

