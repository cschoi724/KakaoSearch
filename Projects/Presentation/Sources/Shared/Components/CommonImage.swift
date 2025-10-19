//
//  CommonImage.swift
//  Presentation
//
//  Created by 일하는석찬 on 10/19/25.
//  Copyright © 2025 annyeongjelly. All rights reserved.
//

import SwiftUI

/// 공통 이미지 뷰 (원격/로컬 모두)
public struct CommonImage: View {
    public enum Source: Equatable {
        case remote(String)         // 원격 URL 문자열
        case asset(String)           // 로컬 에셋 이름
        case system(String)          // SF Symbol
    }

    public enum Mode {
        case fill, fit
    }

    private let source: Source
    private let mode: Mode
    private let width: CGFloat?
    private let height: CGFloat?
    private let cornerRadius: CGFloat
    private let background: Color?
    private let placeholder: Image

    public init(
        source: Source,
        mode: Mode = .fill,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        cornerRadius: CGFloat = 0,
        background: Color? = nil,
        placeholder: Image = Image(systemName: "photo")
    ) {
        self.source = source
        self.mode = mode
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.background = background
        self.placeholder = placeholder
    }

    public var body: some View {
        ZStack {
            switch source {
            case .asset(let name):
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: mode == .fill ? .fill : .fit)

            case .system(let name):
                Image(systemName: name)
                    .resizable()
                    .aspectRatio(contentMode: mode == .fill ? .fill : .fit)

            case .remote(let urlString):
                if let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            placeholderView
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: mode == .fill ? .fill : .fit)
                        case .failure:
                            placeholderView
                        @unknown default:
                            placeholderView
                        }
                    }
                    
                } else {
                    placeholderView
                }
            }
        }
        .frame(width: width, height: height)
        .background(background)
        .clipped()
        .cornerRadius(cornerRadius)
    }

    private var placeholderView: some View {
        ZStack {
            (background ?? Color(.secondarySystemFill))
            placeholder
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(Color(.tertiaryLabel))
        }
    }
}
