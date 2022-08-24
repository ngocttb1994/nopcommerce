*** Settings ***
Library     SeleniumLibrary
Resource    ../PageObjects/NopcommercePageObject.robot

Test Setup      Open website
Test Teardown   close my browser

*** Test Cases ***
Register and Login and Sort
    Click register link
    Verify Register Page
    Register and login account
    Select category
    Sort by Price Low to High
    Sort by Price High to Low