Meta:
    @group Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
|userName        		|password			|
|${swagGoodUserName}	|${swagPassword}	|
|${swagSlowUserName}	|${swagPassword}	|


Scenario: Navigate to the website homepage
Given I am on main application page
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I take screenshot

Scenario: Log In
When I enter `<userName>` in field located by `id(user-name)`
And I enter `<password>` in field located by `id(password)`
And I click on element located by `id(login-button)`
Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
And each element with locator `className(inventory_container)` has `6` child elements with locator `className(inventory_item)`
And dropdown located `className(product_sort_container)` exists and selected option is `Name (A to Z)`
And text `Products` exists
When I take screenshot

Scenario: Add item to the shopping cart
When I click on element located by `<addToCartButtonId>`
When I wait until element located by `<itemName>` has text matching `<textButton>`
When I take screenshot

Examples:
|itemName										|addToCartButtonId  								 |textButton|
|id(remove-sauce-labs-backpack)					|id(add-to-cart-sauce-labs-backpack)				 |Remove	|
|id(remove-sauce-labs-bike-light)				|id(add-to-cart-sauce-labs-bike-light)				 |Remove	|
|id(remove-test.allthethings()-t-shirt-(red))	|id(add-to-cart-test.allthethings()-t-shirt-(red))   |Remove	|

Scenario: Validate the num of items in the shopping cart
When I click on element located by `className(shopping_cart_container)`
Then each element with locator `className(cart_list)` has `3` child elements with locator `className(cart_item)`
When I take screenshot

Scenario: Log Out
When I click on element located by `id(react-burger-menu-btn)`
When I click on element located by `id(reset_sidebar_link)`
When I click on element located by `id(logout_sidebar_link)`




