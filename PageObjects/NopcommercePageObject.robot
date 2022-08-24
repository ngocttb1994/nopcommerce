*** Settings ***
Library     SeleniumLibrary
Library    String
Library    XML
Library    Collections
Library    OperatingSystem
Resource    ../Resources/common.robot

*** Variables ***
${url}      https://demo.nopcommerce.com/
${browser}      chrome
${registerLink}     class=ico-register
${registerTitle}    xpath = //div[@class='page-title']//h1
${genderFemale}    id = gender-female
${firstName}    id = FirstName
${lastName}    id = LastName
${email}    id = Email
${company}    id = Company
${newLetter}    id = Newsletter
${password}    id = Password
${confirmPassword}    id = ConfirmPassword
${registerButton}    id = register-button
${registerResult}    class = result
${continueButton}    class = buttons
${logoutLink}    class=ico-logout
${loginLink}    class=ico-login
${emailTextBox}    id=Email
${passwordTextBox}    id=Password
${loginButton}    css=.login-button
${categoryBooks}    xpath=//ul[@class='top-menu notmobile']//a[text()='Books ']
${pageTitle}    xpath=//div[@class='page-title']//h1
${prices}    xpath://div[@class='prices']//span[@class='price actual-price']

*** Keywords ***
Open website
    open my browser     ${url}      ${browser}

Click register link
    click into element    ${registerLink}

Verify Register Page
    Element Should Be Visible    ${registerTitle}

Register and login account
    ${random_string} =  Generate Random String    5    [LOWER]
    click into element    ${genderFemale}
    input into element    ${firstName}    bich
    input into element    ${lastName}    ngoc
    select dropdown    DateOfBirthDay     30
    select dropdown    DateOfBirthMonth   December
    select dropdown    DateOfBirthYear    1994
    input into element    ${email}    ${random_string}@gmail.com
    ${actual_value} =   Get Value    ${email}
    ${email_value}   Set Variable   ${actual_value}
    input into element    ${company}    ABC software
    input into element    ${password}    123456
    input into element    ${confirmPassword}    123456
    click into element    ${registerButton}
    Element Text Should Be    ${registerResult}    Your registration completed
    click into element    ${continueButton}
    click into element    ${logoutLink}
    Page Should Contain Element    ${loginLink}
    click into element    ${loginLink}
    input into element    ${emailTextBox}    ${email_value}
    input into element    ${passwordTextBox}    123456
    click into element    ${loginButton}
    Page Should Contain Element    ${logoutLink}

Select category
    click into element    ${categoryBooks}
    Element Text Should Be    ${pageTitle}    Books

Sort by Price Low to High
    select dropdown    products-orderby    Price: Low to High
    Reload Page
    @{categries_list}=   Create List
    @{get_price}=   Get WebElements        ${prices}
    FOR    ${i}     IN      @{get_price}
    ${get_value_price}=  Get Text    ${i}
    Append To List  ${categries_list}  ${get_value_price}
    END
    ${categories_order}=  Copy list  ${categries_list}
    Sort List    ${categories_order}
    Should Be Equal As Strings    ${categories_order}    ${categries_list}

Sort by Price High to Low
    select dropdown    products-orderby    Price: High to Low
    Reload Page
    @{categries_list}=   Create List
    @{get_price}=   Get WebElements        ${prices}
    FOR    ${each}     IN      @{get_price}
    ${get_value_price}=  Get Text    ${each}
    Append To List  ${categries_list}  ${get_value_price}
    END
    ${categories_order}=  Copy list  ${categries_list}
    Sort List    ${categories_order}
    Reverse List    ${categories_order}
    Should Be Equal As Strings    ${categories_order}    ${categries_list}


