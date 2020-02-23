//
//  SettingViewController.swift
//  Muilt Screen Switcher
//
//  Created by CYC on 2017/4/24.
//  Copyright © 2017年 West2Studio. All rights reserved.
//

import Cocoa

class SettingViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet var tableview: NSTableView!

    @IBOutlet var displayTable: NSTableView!

    @IBOutlet var noteTextfield: NSTextField!

    var _profile = ProfileHelper.shared.profiles

    override func viewDidLoad() {
        super.viewDidLoad()
        NSApp.activate(ignoringOtherApps: true)
        view.window?.makeKeyAndOrderFront(self)
        tableview.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        bindData()
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView.tag == 1 {
            return _profile.count
        } else {
            let selectedRow = tableview.selectedRow
            return selectedRow == -1 ? 0 : _profile[selectedRow].displays.count
        }
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableView.tag == 1 {
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "profileCell"), owner: nil) as! NSTableCellView
            cell.textField?.bind(NSBindingName(rawValue: "value"), to: _profile[row], withKeyPath: "note", options: [NSBindingOption.continuouslyUpdatesValue: true])
            return cell

        } else {
            let selected_profile = tableview.selectedRow
            let displays = _profile[selected_profile].displays

            if tableColumn == displayTable.tableColumns[0] {
                // Display id
                let cell = displayTable.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "displayid"), owner: nil) as! NSTableCellView
                cell.textField?.stringValue = String(displays[row].screen_id)
                return cell

            } else if tableColumn == displayTable.tableColumns[1] {
                // Position
                let cell = displayTable.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "displayPosition"), owner: nil) as! NSTableCellView
                cell.textField?.stringValue = "\(displays[row].position_x),\(displays[row].position_y)"
                return cell
            }
            return nil
        }
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        guard tableView.tag == 1 else { return true }

        if row < 0 { return false }
        let index = tableView.selectedRow
        if index < 0 { return true }

        if !_profile[index].isValid() {
            let alert = NSAlert()
            alert.messageText = "输入不合法"
            alert.informativeText = "备注不能为空"
            alert.addButton(withTitle: "ok")
            alert.beginSheetModal(for: view.window!, completionHandler: nil)
            return false
        }

        return true
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let table = notification.object as? NSTableView else { return }
        guard table.tag == 1 else { return }
        let index = table.selectedRow
        guard index >= 0 else { return }
        displayTable.reloadData()
        bindData()
    }

    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        if tableView.tag == 1 && _profile.count > 0 {
            tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        }
    }

    func bindData() {
        let index = tableview.selectedRow
        if index < 0 { return }
        noteTextfield.bind(NSBindingName(rawValue: "value"), to: _profile[index], withKeyPath: "note", options: [NSBindingOption.continuouslyUpdatesValue: true])
    }

    @IBAction func addCurrent(_ sender: Any) {
        let new_profile = ScreenHelper.shared.getProfile()
        _profile.append(new_profile)
        tableview.reloadData()
        tableview.selectRowIndexes(IndexSet(integer: _profile.count - 1), byExtendingSelection: false)
    }

    @IBAction func deleteCurrent(_ sender: Any) {
        let index = tableview.selectedRow
        if index < 0 || index > _profile.count { return }
        _profile.remove(at: index)
        tableview.removeRows(at: IndexSet(integer: index), withAnimation: .effectFade)
        displayTable.reloadData()
    }

    @IBAction func saveAndExit(_ sender: Any) {
        ProfileHelper.shared.profiles = _profile

        (NSApp.delegate as! AppDelegate).updateMenu()

        dismiss(nil)
    }
}
