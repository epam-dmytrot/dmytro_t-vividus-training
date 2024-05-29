Meta:
    @group Training
    @requirementId MyTask-0008

Scenario: Navigate to the website homepage
Given I open the Login page

Scenario: Log In
When I login with ${swagGoodUserName} and ${swagPassword}

Scenario: Add items to the shopping cart
When I select `<sortingValue>` in dropdown located `name(product_sort_container)`
When I click on element located by `xpath(//*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/button)`
!-- I click on element located by `xpath(//*[@id="inventory_container"]/div/div[last()]/div[2]/div[2]/button)`
When I wait until element located by `xpath(//*[@id="shopping_cart_container"]/a/span)` has text matching `<cartBadgeCount>`
When I save text of element located by `xpath(//*[@id="inventory_container"]/div/div[1]/div[2]/div[2]/div)` to story variable `<price>`
Examples:
|sortingValue			|cartBadgeCount	|price		|
|Price (low to high)	|1				|cheapest	|
|Price (high to low)	|2				|expensive	|

Scenario: Populate checkout data
Given I initialize story variable `checkoutFirstName` with value `#{generate(Name.firstName)}`
Given I initialize story variable `checkoutLastName` with value `#{capitalizeFirstWord(#{generate(regexify '[a-z]{10}')})}`
Given I initialize story variable `postalCode` with value `#{generate(regexify '[A-Z]{3}')}-#{generate(regexify '[0-9]{5}')}`

When I click on element located by `className(shopping_cart_container)`
Then each element with locator `className(cart_list)` has `2` child elements with locator `className(cart_item)`
When I take screenshot

When I click on element located by `name(Checkout)`
When I ${baselineAction} baseline with name `checkoutOne` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE	|
|5							|

When I enter `${checkoutFirstName}` in field located by `id(first-name)`
When I enter `${checkoutLastName}` in field located by `id(last-name)`
When I enter `${postalCode}` in field located by `id(postal-code)`
When I take screenshot

Scenario: Validate order summary and complete order
Given I initialize STORY variable `message` with value `#{loadResource(/data/message.txt)}`
When I click on element located by `name(Continue)`
When I ${baselineAction} baseline with name `checkoutTwo` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE	|
|5							|
When I take screenshot

!-- Getting subtotal from UI
When I save text of element located by `className(summary_subtotal_label)` to story variable `subtotalUi`
Given I initialize story variable `subtotalUiInt` with value `#{round(#{eval(#{substringAfter(${subtotalUi},$)})}, 2)}`

!-- Getting total from UI
When I save text of element located by `className(summary_total_label)` to story variable `totalUi`
Given I initialize story variable `totalUiInt` with value `#{round(#{eval(#{substringAfter(${totalUi},$)})}, 2)}`

!-- Calculate tax (8% of subtotal)
Given I initialize story variable `tax` with value `#{round(#{eval(subtotalUiInt*0.08)}, 2)}`

!-- Calculate Total (subtotal + tax)
Given I initialize story variable `totalCalculated` with value `#{eval(${subtotalUiInt}+${tax})}`

!-- Subtotal verification
Then `#{round(#{eval(#{substringAfter(${cheapest},$)} + #{substringAfter(${expensive},$)})}, 2)}` is = `${subtotalUiInt}`

!-- Total verification (I used 4 different approaches just for practicing)
Then `#{eval(#{eval(${subtotalUiInt}+${tax})}==${totalUiInt})}` is = `true`
Then `#{eval(${subtotalUiInt}+${tax})}` is = `${totalUiInt}`
Then `#{eval(${subtotalUiInt}+${tax}==${totalUiInt})}` is = `true`
Then `${totalCalculated}` matches `${totalUiInt}`

When I take screenshot
When I click on element located by `name(Finish)`
When I take screenshot
When I save text of element located by `className(complete-header)` to story variable `thankYou`
Then `${thankYou}` matches `${message}`
