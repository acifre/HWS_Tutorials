//
//  AppSettingsView.swift
//  HotProspects
//
//  Created by Anthony Cifre on 6/7/23.
//

import SwiftUI

struct AppSettingsView: View {

    @ObservedObject private var viewModel = AppSettingsViewModel()
       
    var body: some View {
        Text(viewModel.title)
    }

}

struct AppSettings_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
