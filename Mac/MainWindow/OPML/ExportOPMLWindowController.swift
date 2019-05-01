//
//  ExportOPMLWindowController.swift
//  NetNewsWire
//
//  Created by Maurice Parker on 5/1/19.
//  Copyright © 2019 Ranchero Software. All rights reserved.
//

import AppKit
import Account

class ExportOPMLWindowController: NSWindowController {

	@IBOutlet weak var accountPopUpButton: NSPopUpButton!
	private weak var hostWindow: NSWindow?
	
	convenience init() {
		self.init(windowNibName: NSNib.Name("ExportOPMLSheet"))
	}
	
	override func windowDidLoad() {
		
		accountPopUpButton.removeAllItems()
		let menu = NSMenu()
		for oneAccount in AccountManager.shared.sortedAccounts {
			let oneMenuItem = NSMenuItem()
			oneMenuItem.title = oneAccount.nameForDisplay
			oneMenuItem.representedObject = oneAccount
			menu.addItem(oneMenuItem)
		}
		accountPopUpButton.menu = menu
		
	}

	// MARK: API
	
	func runSheetOnWindow(_ hostWindow: NSWindow) {
		self.hostWindow = hostWindow
		hostWindow.beginSheet(window!)
	}
	
	// MARK: Actions
	
	@IBAction func cancel(_ sender: Any) {
		hostWindow!.endSheet(window!, returnCode: NSApplication.ModalResponse.cancel)
	}
	
	@IBAction func exportOPML(_ sender: Any) {

		guard let menuItem = accountPopUpButton.selectedItem else {
			return
		}
		let account = menuItem.representedObject as! Account
		
		hostWindow!.endSheet(window!, returnCode: NSApplication.ModalResponse.OK)
		
		let panel = NSSavePanel()
		panel.allowedFileTypes = ["opml"]
		panel.allowsOtherFileTypes = false
		panel.prompt = NSLocalizedString("Export OPML", comment: "Export OPML")
		panel.title = NSLocalizedString("Export OPML", comment: "Export OPML")
		panel.nameFieldLabel = NSLocalizedString("Export to:", comment: "Export OPML")
		panel.message = NSLocalizedString("Choose a location for the exported OPML file.", comment: "Export OPML")
		panel.isExtensionHidden = false
		panel.nameFieldStringValue = "MySubscriptions.opml"
		
		panel.beginSheetModal(for: hostWindow!) { result in
			if result == NSApplication.ModalResponse.OK, let url = panel.url {
				DispatchQueue.main.async {
					let filename = url.lastPathComponent
					let opmlString = OPMLExporter.OPMLString(with: account, title: filename)
					do {
						try opmlString.write(to: url, atomically: true, encoding: String.Encoding.utf8)
					}
					catch let error as NSError {
						NSApplication.shared.presentError(error)
					}
				}
			}
		}
		


	}
}
