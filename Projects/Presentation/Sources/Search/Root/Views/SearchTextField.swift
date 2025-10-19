//
//  SearchTextField.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    let placeholder: String
    var onSubmit: () -> Void

    var body: some View {
        TextField(placeholder, text: $text)
            .textInputAutocapitalization(.none)
            .autocorrectionDisabled()
            .submitLabel(.search)
            .onSubmit(onSubmit)
    }
}
