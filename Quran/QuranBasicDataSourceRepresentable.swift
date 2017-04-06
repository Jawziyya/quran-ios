//
//  QuranBasicDataSourceRepresentable.swift
//  Quran
//
//  Created by Mohamed Afifi on 3/19/17.
//  Copyright © 2017 Quran.com. All rights reserved.
//

import Foundation
import GenericDataSources

protocol QuranBasicDataSourceRepresentable: BasicDataSourceRepresentable {
    associatedtype Item = QuranPage

    func highlightAyaht(_ ayat: Set<AyahNumber>, isActive: Bool)
    func applicationDidBecomeActive()
    func invalidate()
}

class AnyQuranBasicDataSourceRepresentable<Item>: AnyBasicDataSourceRepresentable<Item>, QuranBasicDataSourceRepresentable {

    private let highlightAyatBlock: (Set<AyahNumber>, Bool) -> Void
    private let becomeActiveBlock: () -> Void
    private let invalidateBlock: () -> Void

    override init<DS: QuranBasicDataSourceRepresentable>(_ ds: DS) where DS.Item == Item {
        highlightAyatBlock = ds.highlightAyaht
        becomeActiveBlock = ds.applicationDidBecomeActive
        invalidateBlock = ds.invalidate
        super.init(ds)
    }

    func highlightAyaht(_ ayat: Set<AyahNumber>, isActive: Bool) {
        return highlightAyatBlock(ayat, isActive)
    }

    func applicationDidBecomeActive() {
        return becomeActiveBlock()
    }

    func invalidate() {
        return invalidateBlock()
    }
}

extension QuranBasicDataSourceRepresentable {
    func asQuranBasicDataSourceRepresentable() -> AnyQuranBasicDataSourceRepresentable<Item> {
        return AnyQuranBasicDataSourceRepresentable(self)
    }
}
