Scenario: Navigate to the website homepage
Given I open the Login page
When I ${baselineAction} baseline with name `loginPageNew` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE	|
|5							|

Scenario: Log in as a Broken User
When I login with ${swagUserName} and ${swagPassword}
Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
When I ${baselineAction} baseline with name `homepageNew` ignoring:
|ELEMENT						|ACCEPTABLE_DIFF_PERCENTAGE |
|className(inventory_item_img)	|18							|
