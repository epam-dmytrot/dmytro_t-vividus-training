Meta:
    @group Training
    @requirementId MyTask-0008

Scenario: Navigate to the website homepage
Given I open the Login page

Scenario: Log In
When I login with ${swagGoodUserName} and ${swagPassword}

Scenario: Add items to the shopping cart
!-- Select cheapest item
When I select `Price (low to high)` in dropdown located `name(product_sort_container)`
When I click on element located by `xpath(/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[2]/button)`
When I save text of element located by `xpath(/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[2]/div)` to story variable `cheapest`

!-- Select expensive  item
When I select `Price (high to low)` in dropdown located `name(product_sort_container)`
When I click on element located by `xpath(/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[2]/button)`
When I save text of element located by `xpath(/html/body/div/div/div/div[2]/div/div/div/div[1]/div[2]/div[2]/div)` to story variable `expensive`

!-- Calculate Checkout Price
Given I initialize story variable `checkoutPrice` with value `#{round(#{eval(#{substringAfter(${cheapest},$)} + #{substringAfter(${expensive},$)})}, 2)}`
When I take screenshot

Scenario: Populate checkout data
Given I initialize story variable `checkoutFirstName` with value `#{generate(Name.firstName)}`
Given I initialize story variable `checkoutLastName` with value `#{capitalizeFirstWord(#{generate(regexify '[a-z]{10}')})}`
Given I initialize story variable `postalCode` with value `#{generate(regexify '[A-Z]{3}')}-#{generate(regexify '[0-9]{5}')}`

When I click on element located by `className(shopping_cart_container)`
Then each element with locator `className(cart_list)` has `2` child elements with locator `className(cart_item)`
When I take screenshot

When I click on element located by `name(Checkout)`
When I enter `${checkoutFirstName}` in field located by `id(first-name)`
When I enter `${checkoutLastName}` in field located by `id(last-name)`
When I enter `${postalCode}` in field located by `id(postal-code)`
When I take screenshot

Scenario: Validate order summary and complete order
Given I initialize STORY variable `message` with value `#{loadResource(/data/message.txt)}`
When I click on element located by `name(Continue)`
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

!-- Total/Subtotal verification 
Then `${checkoutPrice}` matches `${subtotalUiInt}`
Then `${totalCalculated}` matches `${totalUiInt}`

When I take screenshot
When I click on element located by `name(Finish)`
When I take screenshot
When I save text of element located by `className(complete-header)` to story variable `thankYou`
Then `${thankYou}` matches `${message}`

