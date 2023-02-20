//
//  ItemModelTest.swift
//  vkservices_appTests
//
//  Created by xyz mac on 19.02.2023.
//

import XCTest
@testable import vkservices_app

final class ItemModelTest: XCTestCase {
    private var sut: Item!

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = Item(
            name: "ВКонтакте",
            description: "Самая популярная соцсеть и первое суперприложение в Роcсии",
            icon_url: "https://mobile-olympiad-trajectory.hb.bizmrg.com/logo-vk.png",
            service_url: "https://vk.com/"
        )
    }

    override func tearDownWithError() throws {
        sut = nil

        try super.tearDownWithError()
    }

    func testCorrectInstance() throws {
        XCTAssert(sut.name == "ВКонтакте", "Wrong name")
        XCTAssert(sut.description == "Самая популярная соцсеть и первое суперприложение в Роcсии", "Wrong description")
        XCTAssert(sut.icon_url == "https://mobile-olympiad-trajectory.hb.bizmrg.com/logo-vk.png", "Wrong icon_url")
        XCTAssert(sut.service_url == "https://vk.com/", "Wrong service_url")
    }
    
}
