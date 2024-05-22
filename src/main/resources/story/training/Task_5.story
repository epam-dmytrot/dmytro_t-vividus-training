Scenario: Navigate to the website homepage
Given I am on main application page
When I wait until element located by `caseSensitiveText(Swag Labs)` appears
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I take screenshot

Scenario: Log in as Locked User
When I enter `${swagLockedUserName}` in field located by `id(user-name)`
And I enter `${swagPassword}` in field located by `id(password)`
And I click on element located by `id(login-button)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
And each element with locator `className(inventory_container)` has `6` child elements with locator `className(inventory_item)`
When I take screenshot