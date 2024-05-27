Scenario: Create new baseline for LoginPage
Given I open the Login page
When I take screenshot
When I ESTABLISH baseline with name `loginPageNew`

Scenario: Navigate to the website homepage
Given I open the Login page
When I ${baselineAction} baseline with name `loginPageNew` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE	|
|5							|

Scenario: Log in as a Good User
When I login with ${swagGoodUserName} and ${swagPassword}
Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
When I ESTABLISH baseline with name `homepageNew`
When I login logout

Scenario: Log in as a Broken User
When I login with ${swagBrokenUserName} and ${swagPassword}
Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
When I ${baselineAction} baseline with name `homepageNew` ignoring:
|ELEMENT						|ACCEPTABLE_DIFF_PERCENTAGE |
|className(inventory_item_img)	|18							|
