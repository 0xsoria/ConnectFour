//
//  main.swift
//  ConnectFour
//
//  Created by Gabriel Soria Souza on 25/09/21.
//

import AppKit

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
