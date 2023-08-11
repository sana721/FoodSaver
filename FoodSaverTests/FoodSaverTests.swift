//
//  FoodSaverTests.swift
//  FoodSaverTests
//
//  Created on 06/12/22.
//

import XCTest
@testable import FoodSaver

class FoodSaverTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "test_user"
        signupViewModel.password.value = "password"
        signupViewModel.confirmPassword.value = "password"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyz.com"
        signupViewModel.aboutMe.value = "About me"
        signupViewModel.address.value = "New York"
        signupViewModel.photo.value = UIImage(named: "User")
        signupViewModel.save { (status) in
            XCTAssert(status == true)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        if let account = DBManager.manager.accountForUsername(username: "test_user") {
            DBManager.manager.deleteEntity(entity: account)
        }
    }
    
    func testSignupValidations1() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations2() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations3() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations4() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations5() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations6() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations7() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations8() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyz.com"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations9() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyz.com"
        signupViewModel.aboutMe.value = "About me"
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations10() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyz.com"
        signupViewModel.aboutMe.value = "About me"
        signupViewModel.address.value = "New York"
        signupViewModel.photo.value = UIImage(named: "User")
        signupViewModel.isValide { (status) in
            XCTAssert(status == true)
            XCTAssert(signupViewModel.validationError.count == 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations11() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyzcom"
        signupViewModel.aboutMe.value = "About me"
        signupViewModel.address.value = "New York"
        signupViewModel.photo.value = UIImage(named: "User")
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignupValidations12() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd1"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyzcom"
        signupViewModel.aboutMe.value = "About me"
        signupViewModel.address.value = "New York"
        signupViewModel.photo.value = UIImage(named: "User")
        signupViewModel.isValide { (status) in
            XCTAssert(status == false)
            XCTAssert(signupViewModel.validationError.count > 0)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testSignup() {
        let exception = self.expectation(description: "validation")
        let signupViewModel = SignUpViewModel()
        signupViewModel.username.value = "username"
        signupViewModel.password.value = "pwd"
        signupViewModel.confirmPassword.value = "pwd"
        signupViewModel.firstname.value = "First name"
        signupViewModel.lastname.value = "Last name"
        signupViewModel.phone.value = "1234567890"
        signupViewModel.email.value = "abc@xyz.com"
        signupViewModel.aboutMe.value = "About me"
        signupViewModel.address.value = "New York"
        signupViewModel.photo.value = UIImage(named: "User")
        signupViewModel.save { (status) in
            XCTAssert(status == true)
            if let account = DBManager.manager.accountForUsername(username: "username") {
                DBManager.manager.deleteEntity(entity: account)
            }
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginValidation1() {
        let exception = self.expectation(description: "login Validations")
        let loginViewModel = LoginViewModel()
        loginViewModel.doLogin { (error) in
            XCTAssertNotNil(error)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginValidation2() {
        let exception = self.expectation(description: "login Validations")
        let loginViewModel = LoginViewModel()
        loginViewModel.username.value = "username"
        loginViewModel.doLogin { (error) in
            XCTAssertNotNil(error)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginValidation3() {
        let exception = self.expectation(description: "login Validations")
        let loginViewModel = LoginViewModel()
        loginViewModel.username.value = "username"
        loginViewModel.password.value = "password"
        loginViewModel.doLogin { (error) in
            XCTAssertNotNil(error)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLoginValidation4() {
        let exception = self.expectation(description: "login Validations")
        let loginViewModel = LoginViewModel()
        loginViewModel.username.value = "test_user"
        loginViewModel.password.value = "password123"
        loginViewModel.doLogin { (error) in
            XCTAssertNotNil(error)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testLogin() {
        let exception = self.expectation(description: "login Validations")
        let loginViewModel = LoginViewModel()
        loginViewModel.username.value = "test_user"
        loginViewModel.password.value = "password"
        loginViewModel.doLogin { (error) in
            XCTAssertNil(error)
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAddFoodValidations1() {
        let addFoodVM = AddFoodViewModel()
        let result = addFoodVM.isValid()
        XCTAssert(result == false)
    }
    
    func testAddFoodValidations2() {
        let addFoodVM = AddFoodViewModel()
        addFoodVM.title.value = "Food"
        let result = addFoodVM.isValid()
        XCTAssert(result == false)
    }
    
    func testAddFoodValidations3() {
        let addFoodVM = AddFoodViewModel()
        addFoodVM.title.value = "Food"
        addFoodVM.quantity.value = 100
        let result = addFoodVM.isValid()
        XCTAssert(result == false)
    }
    
    func testAddFoodValidations4() {
        let addFoodVM = AddFoodViewModel()
        addFoodVM.title.value = "Food"
        addFoodVM.quantity.value = 100
        addFoodVM.description.value = "Food Dec"
        addFoodVM.photo.value = UIImage(named: "food")
        let result = addFoodVM.isValid()
        XCTAssert(result == true)
    }
    
    func testAddFoodSave1() {
        let exception = self.expectation(description: "Add Food")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            if let food = addFoodVM.addedFood {
                DBManager.manager.deleteEntity(entity: food)
            }
            AppManager.manager.loginAccount = nil
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAddFoodSave2() {
        // with out login
        let addFoodVM = AddFoodViewModel()
        addFoodVM.title.value = "Food"
        addFoodVM.quantity.value = 100
        addFoodVM.description.value = "Food Dec"
        addFoodVM.photo.value = UIImage(named: "food")
        var result = addFoodVM.isValid()
        XCTAssert(result == true)
        result = addFoodVM.save()
        XCTAssert(result == false)
        if let food = addFoodVM.addedFood {
            DBManager.manager.deleteEntity(entity: food)
        }
    }
    
    func testFoods1() {
        let exception = self.expectation(description: "Foods")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            addFoodVM.title.value = "Food2"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .nonVeg
            addFoodVM.photo.value = UIImage(named: "food")
            result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            let foodVM = FoodViewModel()
            foodVM.loadAllAvialabelFood()
            XCTAssert(foodVM.food.value.count == 2)
            
            for food in foodVM.food.value {
                DBManager.manager.deleteEntity(entity: food)
            }
            DBManager.manager.saveContext()
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoods2() {
        let exception = self.expectation(description: "Foods")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            addFoodVM.title.value = "Food2"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .nonVeg
            addFoodVM.photo.value = UIImage(named: "food")
            result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            let foodVM = FoodViewModel()
            foodVM.loadAllAvialabelFood()
            XCTAssert(foodVM.food.value.count == 2)
            
            foodVM.applyFilter(filter: .nonveg)
            XCTAssert(foodVM.food.value.count == 1)
            XCTAssert(foodVM.food.value.first?.isVeg == false)
            
            foodVM.applyFilter(filter: .veg)
            XCTAssert(foodVM.food.value.count == 1)
            XCTAssert(foodVM.food.value.first?.isVeg == true)
            
            foodVM.applyFilter(filter: .all)
            XCTAssert(foodVM.food.value.count == 2)
            
            for food in foodVM.food.value {
                DBManager.manager.deleteEntity(entity: food)
            }
            DBManager.manager.saveContext()
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoods3() {
        let exception = self.expectation(description: "Foods")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            let foodVM = FoodViewModel()
            foodVM.loadAllAvialabelFood()
            XCTAssert(foodVM.food.value.count == 1)
            if let food = foodVM.food.value.first {
                foodVM.addToFavorites(add: true, food: food)
                foodVM.loadAllFavoriteFoodItems()
                XCTAssert(foodVM.favoriteFoods.value.count == 1)
                XCTAssert(foodVM.isFoodFavorite(food: food) == true)
                
                foodVM.addToFavorites(add: false, food: food)
                foodVM.loadAllFavoriteFoodItems()
                XCTAssert(foodVM.favoriteFoods.value.count == 0)
            } else {
                XCTAssert(false)
            }
                        
            for food in foodVM.food.value {
                DBManager.manager.deleteEntity(entity: food)
            }
            DBManager.manager.saveContext()
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoods4() {
        let exception = self.expectation(description: "Foods")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            let foodVM = FoodViewModel()
            foodVM.loadAllAvialabelFood()
            XCTAssert(foodVM.food.value.count == 1)
            if let food = foodVM.food.value.first {
                foodVM.addLike(food: food)
                XCTAssert(food.likes == 1)
                
                foodVM.addUnlike(food: food)
                XCTAssert(food.dislike == 1)
            } else {
                XCTAssert(false)
            }
                        
            for food in foodVM.food.value {
                DBManager.manager.deleteEntity(entity: food)
            }
            
            DBManager.manager.saveContext()
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoodDetails1() {
        let exception = self.expectation(description: "Food Details")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                foodVM.addToFavorites(add: true)
                XCTAssert(foodVM.isFoodFavorite() == true)
                foodVM.addToFavorites(add: false)
                XCTAssert(foodVM.isFoodFavorite() == false)
                XCTAssert(foodVM.deleteFood() == true)
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoodDetails2() {
        let exception = self.expectation(description: "Food Details")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                foodVM.addLike()
                XCTAssert(food.likes == 1)
                foodVM.addUnlike()
                XCTAssert(food.dislike == 1)
                XCTAssert(foodVM.deleteFood() == true)
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoodDetails3() {
        let exception = self.expectation(description: "Food Details")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                XCTAssert(foodVM.requestFood() == false)
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoodDetails4() {
        let exception = self.expectation(description: "Food Details")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                foodVM.requestQuantity.value = 200
                XCTAssert(foodVM.requestFood() == false)
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFoodDetails5() {
        let exception = self.expectation(description: "Food Details")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                foodVM.requestQuantity.value = 20
                XCTAssert(foodVM.requestFood() == true)
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRequests1() {
        let exception = self.expectation(description: "Food Request")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                foodVM.requestQuantity.value = 20
                XCTAssert(foodVM.requestFood() == true)
                
                let requestVM = RequestsViewModel()
                requestVM.loadRequests()
                if let request = requestVM.requests.first {
                    XCTAssert(requestVM.accpet(request: request) == true)
                } else {
                    XCTAssert(false)
                }
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testRequests2() {
        let exception = self.expectation(description: "Food Request")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            
            let addFoodVM = AddFoodViewModel()
            addFoodVM.title.value = "Food1"
            addFoodVM.quantity.value = 100
            addFoodVM.description.value = "Food Dec"
            addFoodVM.type.value = .veg
            addFoodVM.photo.value = UIImage(named: "food")
            var result = addFoodVM.isValid()
            XCTAssert(result == true)
            result = addFoodVM.save()
            XCTAssert(result == true)
            
            if let food = addFoodVM.addedFood {
                let foodVM = FoodDetailsViewModel(food: food)
                foodVM.requestQuantity.value = 20
                XCTAssert(foodVM.requestFood() == true)
                
                let requestVM = RequestsViewModel()
                requestVM.loadRequests()
                if let request = requestVM.requests.first {
                    XCTAssert(requestVM.decline(request: request) == true)
                } else {
                    XCTAssert(false)
                }
            } else {
                XCTAssert(false)
            }
            
            exception.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testProfile1() {
        let exception = self.expectation(description: "Profile")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            let profile = ProfileViewModel()
            profile.isValide { (status) in
                XCTAssert(status == true)
                exception.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testProfile2() {
        let exception = self.expectation(description: "Profile")
        //Login
        let loginVM = LoginViewModel()
        loginVM.username.value = "test_user"
        loginVM.password.value = "password"
        loginVM.doLogin { (error) in
            XCTAssertNil(error)
            let profile = ProfileViewModel()
            profile.save { (status) in
                XCTAssert(status == true)
                exception.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAdminFlow1() {
            let adminVM = AdminViewModel()
            adminVM.loadAccounts()
            XCTAssert(adminVM.accounts.count == 1)
        }

        func testAdminFlow2() {
            let adminVM = AdminViewModel()
            adminVM.loadAccounts()
            if let account = adminVM.accounts.first {
                XCTAssert(account.isActive == true)

                adminVM.active(account: account, active: false)
                XCTAssert(account.isActive == false)

                adminVM.active(account: account, active: true)
                XCTAssert(account.isActive == true)
            } else {
                XCTAssert(false)
            }
        }

        func testAdminFlow3() {
            let adminVM = AdminViewModel()
            adminVM.loadAccounts()
            if let account = adminVM.accounts.first {
                adminVM.delete(account: account)
                adminVM.loadAccounts()
                XCTAssert(adminVM.accounts.isEmpty == true)
            } else {
                XCTAssert(false)
            }
        }
}
