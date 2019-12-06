//
//  JsonExampleTests.swift
//  JsonExampleTests
//
//  Created by Administrador on 29/11/19.
//  Copyright © 2019 Jacky Ortiz. All rights reserved.
//

import XCTest
@testable import JsonExample


class JsonExampleTests: XCTestCase {
    
    func testSections() throws {
        let section = SettingsSection(rawValue: 0)
        
    }
    
    func testLoadUsersSuccess() throws {
        let home = HomeViewController()
        XCTAssertNotNil(home.viewDidLoad())
        XCTAssertNotNil(home.signUp)
        let url = "http://granjapp2.appspot.com/users"
        let expectation = XCTestExpectation(description: "loadUsers")
        sharedUsersInstance.getRequest(url: url){(success, array,error) in
            if error == nil{
                    XCTAssertTrue(true)
                    expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    func testLoadTeamsSuccess() throws {
        let url = "http://granjapp2.appspot.com/teams"
        let expectation = XCTestExpectation(description: "loadTeams")
        sharedTeamInstance.getRequest(url: url){ (str, array, error) in
            if error == nil{
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testLoadTeamSuccess() throws {
        let url = "http://granjapp2.appspot.com/teams/"
        let expectation = XCTestExpectation(description: "loadOneTeam")
        sharedTeamInstance.getByIdRequest(url: url, id: String(3)){(team, error) in
            if error == nil{
                XCTAssertNotNil(team)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testLoadZonesSuccess() throws {
        let url = "http://granjapp2.appspot.com/zone"
        let expectation = XCTestExpectation(description: "loadZones")
        sharedZoneInstance.getRequest(url: url){ (str, array, error) in
            if error == nil{
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testLoadSubZonesSuccess() throws {
        let url = "http://granjapp2.appspot.com/zone"
        let expectation = XCTestExpectation(description: "loadSubzones")
        sharedSubzoneInstance.getRequest(url: url){ (str, array, error) in
            if error == nil {
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testCreateTeamSuccess() throws {
        let url = "http://granjapp2.appspot.com/teams/"
        let tmp = ["name": "equipo B", "description": "creado por si el A falla"] as [String:Any]
        let expectation = XCTestExpectation(description: "createTeam")
        sharedTeamInstance.postRequest(url: url, body: tmp){(success) in    
            if success{
                XCTAssertTrue(success)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testEditTeamSuccess() throws {
        let url = "http://granjapp2.appspot.com/teams/"
        let id = String(3)
        let name = "Porvenir"
        let description = "comunidad "
        let expectation = XCTestExpectation(description: "editTeam")
        sharedTeamInstance.putRequest(url: url, id: id, name: name, description: description){ (success) in
            if success{
                XCTAssertTrue(success)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testDeleteTeamSuccess() throws {
        let url = "http://granjapp2.appspot.com/teams/"
        let expectation = XCTestExpectation(description: "deleteTeam")
        sharedTeamInstance.deleteRequest(url: url, id: String(13)){ (success) in
            if success{
                XCTAssertTrue(success)
                expectation.fulfill()
            }
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
        
    func testshowPopUpWindow() throws {
        let view = ActivitiesController()
        XCTAssertNotNil(view.handleShowPopUp)
    }
    
    func testgetUserSuccess() throws {
        let url = "http://granjapp2.appspot.com/users/"
        sharedUsersInstance.getByIdRequest(url: url, id: String(15)){ (user, error) in
            XCTAssertNil(error)
        }
    }
    
    func testdeleteUserSuccess() throws {
        sharedUsersInstance.deleteRequest(url:
        "http://granjapp2.appspot.com/users/", id: String(24)){
            (success) in
            XCTAssertTrue(success)
        }
    }
    
    func testgetAnimalsSuccess() throws {
        let vc = AnimalViewController()
        teamid = 3
        XCTAssertNotNil(vc.load())
    }
    
    func testinfoheader() throws {
        let v = UserInfoHeader()
        XCTAssertNotNil(type(of: v).init())
    }
    
    func testCreateAnimalsSuccess() throws {
        let animalc = AnimalViewController()
        let tmp = [ "name": "Camada","fechaNacimiento": "2012-11-04", "equipo": 3,"no_h": 1, "no_m": 2, "salud": 1,"etapa": 2,"especie": 3] as [String : Any]
        sharedAnimalInstance.postRequest(url: "http://granjapp2.appspot.com/animal", body: tmp){ (success) in
            if success{
                XCTAssertTrue(success)
            }
        }
    }
        
    func testGetPlantingSuccess() throws{
        sharedPlantingInstance.getRequest(url: "http://granjapp2.appspot.com/planting"){
            (str, array,error) in
            if error == nil{
                XCTAssertNotNil(array)
                XCTAssertNil(error)
            }
        }
    }
    
    func testGetByIdPlantingSuccess() throws{
        sharedPlantingInstance.getByIdRequest(url: "http://granjapp2.appspot.com/planting/", id: String(8)) {(result,error) in
            if error == nil{
                XCTAssertNotNil(result)
            }
        }
    }
    
    func testTodoCell() throws{
        let cell = TodoCell()
        XCTAssertNotNil(type(of: cell).init())
    }
    
    func testSettingsCell() throws {
        let cell = SettingsCell()
        XCTAssertNotNil(type(of: cell).init())
    }
    
    func testResourceCell() throws {
        let cell = ResourceCell()
        XCTAssertNotNil(type(of: cell).init())
    }
    
    func testUserCell() throws {
        let cell = UserCell()
        XCTAssertNotNil(type(of: cell).init())
    }
    
    func testZoneCell() throws{
        let cell = ZoneCell()
        XCTAssertNotNil(type(of: cell).init())
        
    }
    
    func testResourceTypeCell() throws {
        let cell = ResourceTypeCell()
        XCTAssertNotNil(type(of: cell).init())
    }
    
    func testAddZone() throws {
        let controller = AddAZoneViewController()
        XCTAssertNotNil(controller.viewDidLoad())
    }
    
    func testprofileController() throws {
        let controller = ProfileController()
        XCTAssertNotNil(controller.viewDidLoad())
    }
    
    
    
    func testLoginSuccess() throws {
        let home = HomeViewController()
        XCTAssertNotNil(home.viewDidLoad())
        XCTAssertNotNil(home.signUp)
        emailTextField?.text = "lilusa12@gmail.com"
        XCTAssertTrue((emailTextField?.isValidEmail(emailStr: emailTextField!.text!))!)
        passwordTextField?.text = "Amy$hadpan99"
    XCTAssertTrue((passwordTextField?.isPasswordValid(passwordTextField!.text!))!)
        XCTAssertNotNil(home.load)
        let success = home.login()
        if success{
            XCTAssertTrue(success)
        }
    }
    
    func testLoginFailed() throws {
        let home = HomeViewController()
        XCTAssertNotNil(home.viewDidLoad())
        XCTAssertNotNil(home.signUp)
        emailTextField?.text = "oos97@hot"
        passwordTextField?.text = "Jk78002@"
        XCTAssertNotNil(home.load)
        let success = home.login()
        XCTAssertFalse(success)
    }
    
    func testSignUpFailed() throws{
        let controller = SignUpController()
        usernametextField?.text = "Lourdes"
        lastnametextField?.text = "Cajica"
        emailtextField?.text = "lilusa12@gmail.com"
        let exists = controller.checkifuserexists()
        XCTAssertTrue(exists)
    }
    
    func testSignUpSuccessful() throws{
        let controller = SignUpController()
        usernametextField?.text = "Daniela"
        lastnametextField?.text = "Carrisales"
        emailtextField?.text = "noobmaster69@gmail.com"
        passwordtextField?.text = "mK67$ksa"
        let exists = controller.checkifuserexists()
        XCTAssertFalse(exists)
    }
    
    func testTabController() throws {
        let vc = TabController()
        XCTAssertNotNil(vc.viewDidLoad())
    }
    
    func testAnimalController() throws {
        let vc = AnimalViewController()
        XCTAssertNotNil(vc.viewDidLoad())
        XCTAssertNotNil(vc.load())
        XCTAssertNotNil(vc.handleShowPopUp())
    }
    
    func testViewAnimal() throws {
        let vc = ViewAnimalController()
        XCTAssertNotNil(vc.viewDidLoad())
    }
    func testViewActivities() throws {
        let vc = ViewActivityController()
        XCTAssertNotNil(vc.viewDidLoad())
    }
    
    func testAddActivity() throws {
        let vc = AddActivityController()
        XCTAssertNotNil(vc.viewDidLoad())
    }
    
    
    
}
