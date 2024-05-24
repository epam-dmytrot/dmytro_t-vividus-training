Meta:
    @group Training
    @requirementId MyTask-0007

Scenario: Navigate to the website homepage
Given I am on main application page
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I take screenshot

Scenario: Log In
When I enter `${swagGoodUserName}` in field located by `id(user-name)`
And I enter `${swagPassword}` in field located by `id(password)`
And I click on element located by `id(login-button)`
Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
When I take screenshot

Scenario: Add item to the shopping cart
When I scroll element located by `<itemName>` into view
When I click on element located by `<addToCartButtonId>`
When I wait until element located by `<removeFromCartButtonId>` has text matching `Remove`
When I take screenshot

Examples:
|removeFromCartButtonId							|addToCartButtonId  								 |itemName									|
|id(remove-sauce-labs-backpack)					|id(add-to-cart-sauce-labs-backpack)				 |name(Sauce Labs Backpack)					|
|id(remove-sauce-labs-bike-light)				|id(add-to-cart-sauce-labs-bike-light)				 |name(Sauce Labs Bike Light)				|
|id(remove-test.allthethings()-t-shirt-(red))	|id(add-to-cart-test.allthethings()-t-shirt-(red))   |name(Test.allTheThings() T-Shirt (Red))	|

Scenario: Populate checkout data
Given I initialize story variable `checkoutFirstName` with value `#{generate(Name.firstName)}`
Given I initialize story variable `checkoutLastName` with value `#{capitalizeFirstWord(#{generate(regexify '[a-z]{10}')})}`
Given I initialize story variable `postalCode` with value `#{generate(regexify '[A-Z]{3}')}-#{generate(regexify '[0-9]{5}')}`

When I click on element located by `className(shopping_cart_container)`
Then each element with locator `className(cart_list)` has `3` child elements with locator `className(cart_item)`
When I take screenshot

When I click on element located by `name(Checkout)`
When I enter `${checkoutFirstName}` in field located by `id(first-name)`
When I enter `${checkoutLastName}` in field located by `id(last-name)`
When I enter `${postalCode}` in field located by `id(postal-code)`
When I take screenshot

Scenario: Complete checkout process
Given I initialize STORY variable `message` with value `#{loadResource(/data/message.txt)}`
When I click on element located by `name(Continue)`
When I take screenshot
When I click on element located by `name(Finish)`
When I take screenshot
When I save text of element located by `className(complete-header)` to story variable `thankYou`
Then `${thankYou}` matches `${message}`



