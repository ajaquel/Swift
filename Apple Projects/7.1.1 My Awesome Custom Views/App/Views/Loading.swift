//
//  Loading.swift
//  SwiftUITest
//
//  Created by Paul Kraft on 23.06.20.
//

import SwiftUI

private struct Loading: ViewModifier {

    let isActive: Bool

    func body(content: Content) -> some View {
        Group {
            if isActive {
                content
                .opacity(0.5)
                .overlay(Color(.systemBackground).opacity(0.5))
                    .overlay(ActivityIndicator().padding(8))
            } else {
                content
            }
        }
    }

}

extension View {

    func loading(_ isActive: Bool) -> some View {
        modifier(Loading(isActive: isActive))
    }

}

private struct ActivityIndicator: View {

    // MARK: Stored properties

    @State var fragmentCount = 10
    @State var isAnimating = false

    // MARK: Views

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<self.fragmentCount) { index in
                self.fragment(in: geometry, atIndex: index)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear { self.isAnimating = true }
        .onDisappear { self.isAnimating = false }
    }

    private func fragment(in geometry: GeometryProxy, atIndex index: Int) -> some View {
        Circle()
        .frame(size: geometry.size.multiplied(by: 1 / CGFloat(fragmentCount)))
        .opacity(isAnimating ? 1 : 0.75)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .offset(y: geometry.size.width / CGFloat(fragmentCount * 2) - geometry.size.height / 2)
        .animation(fragmentAnimation)
        .frame(size: geometry.size)
        .rotationEffect(rotation(atIndex: index))
        .animation(rotationAnimation)
    }

    // MARK: Animations

    private var rotationAnimation: Animation {
        Animation.linear(duration: 2).repeatForever(autoreverses: false)
    }

    private var fragmentAnimation: Animation {
        Animation.linear(duration: 1).repeatForever(autoreverses: true)
    }

    // MARK: Helpers

    private func rotation(atIndex index: Int) -> Angle {
        let degreeOffset = (Double(index) / Double(fragmentCount)) * 360
        return .degrees((self.isAnimating ? 360 : 0) + degreeOffset)
    }

}

extension View {

    fileprivate func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        frame(width: size.width, height: size.height, alignment: alignment)
    }

}

extension CGSize {

    fileprivate func multiplied(by value: CGFloat) -> CGSize {
        CGSize(width: width * value, height: width * value)
    }

}
