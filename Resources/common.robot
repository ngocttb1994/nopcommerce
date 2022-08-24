*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
click into element
    [Arguments]     ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

input into element
    [Arguments]     ${locator}      ${value}
    Wait Until Element Is Visible    ${locator}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${value}

select dropdown
    [Arguments]     ${locator}  ${label}
    Wait Until Element Is Visible    ${locator}
    Select From List By Label    ${locator}     ${label}

open my browser
    [Arguments]     ${url}  ${browser}
    Open Browser    ${url}  ${browser}
    Maximize Browser Window

close my browser
    Close Browser

