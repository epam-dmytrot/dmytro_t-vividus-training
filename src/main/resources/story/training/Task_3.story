Scenario: Log in as a Good User
Given I open the Login page
When I login with ${swagGoodUserName} and ${swagPassword}

Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
And each element with locator `className(inventory_container)` has `6` child elements with locator `className(inventory_item)`
And dropdown located `className(product_sort_container)` exists and selected option is `Name (A to Z)`
And text `Products` exists
When I take screenshot