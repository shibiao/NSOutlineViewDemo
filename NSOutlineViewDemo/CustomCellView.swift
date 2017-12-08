//
//  CustomCellView.swift
//  NSOutlineViewDemo
//
//  Created by sycf_ios on 2017/12/8.
//  Copyright © 2017年 sycf_ios. All rights reserved.
//

import Cocoa

class CustomCellView: NSTableCellView {
    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var txtField: NSTextField!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
