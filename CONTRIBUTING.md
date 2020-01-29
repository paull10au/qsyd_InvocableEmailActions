# Contributing to Invocable Email Actions

First and foremost, thank you for taking the time to contribute! :pray:

The following is a set of guidelines for contributing to Invocable Email Actions.

## Table of Contents

[Code of Conduct](#code-of-conduct)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)
  * [Suggesting Enhancements](#suggesting-enhancements)
  * [Pull Requests](#pull-requests)
  
[Styleguides](#styleguides)

[Additional Notes](#additional-notes)


## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code.


## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report.
Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer: :computer:, and find related reports :mag_right:.

Before creating bug reports, please check [this list](#before-submitting-a-bug-report) as you might find out that you don't need to create one.

When you are creating a bug report, please include as many details as possible.
Fill out [the template](.github/ISSUE_TEMPLATE/BUG_REPORT.md), the information it asks for helps us resolve issues faster.

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### Before Submitting A Bug Report

* Read the [wiki](https://github.com/paull10au/qsyd_InvocableEmailActions/wiki) for documentation and usage.
* Check the [FAQ](https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Frequently-Asked-Questions). Your question might already be answered.
* Perform a [cursory search](https://github.com/search?q=repo%3Apaull10au%2Fqsyd_InvocableEmailActions&type=Issues) to see if the problem has already been reported. If it has **and the issue is still open**, add a comment to the existing issue instead of opening a new one.

#### How Do I Submit A (Good) Bug Report?

Bugs are tracked as [GitHub issues](https://guides.github.com/features/issues/).

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible. For example, when listing steps, **don't just say what you did, but explain how you did it**.
* **Provide specific examples to demonstrate the steps**.
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**
* **Include screenshots and animated GIFs** which show you following the described steps and clearly demonstrate the problem.
* **Include any error messages and information from Mass Action Logs.**

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion, including completely new features and minor improvements to existing functionality.

Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please check [this list](#before-submitting-an-enhancement-suggestion) as you might find out that you don't need to create one.

When you are creating an enhancement suggestion, please include as many details as possible.
Fill out [the template](.github/ISSUE_TEMPLATE/FEATURE_REQUEST.md), including how you imagine you would use the requested feature.

#### Before Submitting An Enhancement Suggestion

* Read the [wiki](https://github.com/paull10au/qsyd_InvocableEmailActions/wiki) for documentation and usage. The feature might already exist. 
* Perform a [cursory search](https://github.com/paull10au/qsyd_InvocableEmailActions/issues?q=is%3Aopen+is%3Aissue+label%3A%22enhancement%22) to see if the enhancement has already been requested. If it has **and the request is still open**, add a comment to the existing request instead of opening a new one.


#### How Do I Submit A (Good) Enhancement Suggestion?

Enhancements are tracked as [GitHub issues](https://guides.github.com/features/issues/).

* **Use a clear and descriptive title** for the issue to identify the suggestion.
* **Provide a step-by-step description** of the suggested enhancement in as many details as possible.
* **Describe the current behavior** and **explain which behavior you expected to see instead** and why.
* **Explain why this enhancement would be useful.**
* **Include screenshots and animated GIFs** which help you demonstrate what you are suggesting.

### Pull Requests

Please follow these steps to have your contribution considered by the maintainers. We follow the [GitHub Flow](https://guides.github.com/introduction/flow/) to submit pull requests from feature branches from forks of this project.

1. Fork the repo
    * https://github.com/paull10au/qsyd_InvocableEmailActions
2. Check out a new branch and name it to what you intend to do
    * Use one branch per fix / feature
3. Commit your changes
    * Follow the [styleguides](#styleguides)
    * Provide a git message that explains what you've done
    * Commit to your forked repository
4. Push to the branch of your forked repository
5. Make a pull request to the main repository
    * Follow all instructions in the [template](.github/PULL_REQUEST_TEMPLATE.md)

While the prerequisites above must be satisfied prior to having your pull request reviewed,
the reviewer(s) may ask you to complete additional design work, tests, or other changes before your pull request can be ultimately accepted.


## Styleguides

### JavaScript Styleguide

All JavaScript must adhere to our [ESLint for LWC Style Rules](https://github.com/salesforce/eslint-config-lwc). Please install the [ESLint LWC Plugin](https://github.com/salesforce/eslint-plugin-lwc) to ensure a baseline for valid consistent code.

- Prefer higher order functions over primitive forms of iterators, eg. (Array methods)[https://www.w3schools.com/jsref/jsref_obj_array.asp]

### Apex Styleguide

- Include the following boilerplate at the top of every file:

```Apex
/**
 *      
     Author:        Paul Lucas
     Company:       Salesforce
     Description:   qsyd_InvocableEmailTemplateAction - Lightning Flow and Process Builder invocable action calling the Messaging.sendEmail API enabling a template based messages.
                    Optionally allows tracking of sent emails.

     Date:          25-Apr-2018
     Reference:     https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm
     Test Class:    qsyd_InvocableEmailTemplateActionTest

     Usage:         Refer to qsyd_InvocableEmailTemplateActionTest methods
     History:
     When           Who                 What

     TODO:
 */
```
- Class and interface names are CamelCase, with the exception of pseudo-namespace prefixes. It is recommended to use the whole word and avoid acronyms/abbreviations, **keeping in mind the 40 character limitation**.
- File names should match the class or interface name and should end with .cls. 
- Method names should be verbs in lowerCamelCase, eg. execute() or executeAsync().
- Constants should be uppercase with logical underscore breakpoints, eg. 
```Apex
private static final Map<String, String> APEX_PAGE_ACTIONS_MAP;
private static final Integer MAX_WIDTH = 99;
```
- Variables should be lowerCamelCase, descriptive but concise and for the most part, should not be abbreviated.

## General Styleguide
ESLint addresses a majority of coding best practices, most of which can conceptually be applied to other languages. Here are  additional code preferences which have or are becoming the coding norm.

- Indentation: Use **tabs** based on **2 or 4 spaces** and stay consistent.
- Variables should be declared at the start of each block.
- Always include **curly braces** when writing conditional block statements.
- Prefer a **ternary operator** over a single conditional statement (if-else).
- Prefer a **switch or case** statement over multiple (> 2) if-else statements.
- Prefer writing self-describing code over inline comments.

> Strive to incorporate the [SOLID](https://en.wikipedia.org/wiki/SOLID) principles when developing either Object Oriented or Functional programming languages.

## Additional Notes

### Issue and Pull Request Labels

Labels help us track and manage issues and pull requests.
Refer to the full list of labels and their descriptions [here](https://github.com/paull10au/qsyd_InvocableEmailActions/labels).

[GitHub search](https://help.github.com/articles/searching-issues/) makes it easy to use labels for finding groups of issues or pull requests you're interested in.

We encourage you to read about [other search filters](https://help.github.com/articles/searching-issues/) which will help you write more focused queries.

