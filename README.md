# CodeMoney42_VitorSiqueira

For the aplication to run just need ro run the command
`ruby codemoney42.rb`

# CodeMoney42

CodeMoney42 is a text-based micro banking system.

For the scope of this challenge, we're gonna use the following terms:
- `account`: an arrangement with the bank in which the customer puts in and removes money and the bank keeps a record of it. Each account is composed of a account holder name, the account number and the account balance;
- `selecting`/`unselecting`: the alternative to logging in and out of the system. Since the system does not use passwords, all the authentication is based on selecting and unselecting the current account;
- `deposit`: an operation of adding positive funds to the currently selected account;
- `transfer`: an operation that moves part of the funds of an account to another account;
- `bank statement`: the record of transfers and deposits of an account, followed by the current balance of the account.

## Instructions:

- Before starting, create a private repository in your GitLab account and give it access to your mentor
- The repository should be a Ruby project with dependencies managed with Bundler
- The app does **not** need a graphical interface, it is basic a [TUI app](https://en.wikipedia.org/wiki/Text-based_user_interface)
- You should use RSpec for the tests
- Each task should be a separate Pull Request / Merge Request in the repository
- Create a Central card for each task

## Task 1 - Account Management

This feature consists of 2 functionalities:
- The "Main menu" with the options
  - "Select account": only if there is some account created already
  - "Create account": this should ask for the holder name of the account and then create it with an automatically generated account number. After the account is created, it is automatically selected and the user is taken to the Account menu
  - "Exit": exit the app
- The "Account menu", after selecting an account, the user sees a menu with the options:
  - "Change account holder name": ask for the new holder name of the selected account
  - "Unselect account": takes the user to the main menu

It is not necessary to add an option to delete accounts.

Write tests to ensure your code works.

## Task 2 - Deposit

Allow the user to make a deposit to the selected account. The option to make the deposit should be shown in the Account menu. It should be only possible to make deposits of values larger than zero.

Write tests to ensure your code works.

## Task 3 - Transferring funds between accounts

In the Account menu, add an option that allows the selected account to transfer funds to a different account. The transferred value should be always larger than zero. If a transfer would cause the current account to have a negative balance, the transfer should be canceled and an error should be shown.

Write tests to ensure your code works.

## Extra task 1 - Bank statement

In the Account menu, add an option that allows the user to see the bank statement of the current account. The statement should be composed of a list of all the operations that affect the current account (deposits and transfers), followed by the current balance of the account.
 
Write tests to ensure your code works.

## Extra task 2 - Persistence

At this point, the data of the application is totally stored in memory, so if we close the app we lose everything we did. In this task you're going to persist the state of the app in a JSON file. This is composed of two parts:

- When the app starts, check if a file called `bank.json` exists and, if so, read its content to set the initial value of the application
- After every change in the application state (creating a new account, updating the account holder name, deposits and transfers), update the file `bank.json` to reflect the current state of the application.

The file should look like this:

```json
{
  "accounts": [
    { "number": "0001", "holder_name": "The holder" },
    { "number": "0002", "holder_name": "The other holder" }
  ],
  "operations": [
    { "type": "deposit", "to": "0001", "value": 10 },
    { "type": "transfer", "from": "0001", "to": "0002", "value": 5 }
  ]
}
```