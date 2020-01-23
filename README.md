<div>
	<img align="right" width="150" src="https://qbranch-sydney.s3-ap-southeast-2.amazonaws.com/qbranch_logo.gif">
</div>

# Invocable Email Actions

[![Stars][stars-shield]][repository-url] [![Forks][forks-shield]][repository-url] [![Downloads][downloads-shield]][downloads-url] [![Issues][issues-shield]][issues-url]

#### The full power of emails - declaratively! 

#### Apex email actions available for Process Builder and Lightning Flow Builder leveraging the <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm">SingleEmailMessage Class.</a>

		
<h4 align="center">
	<a href="#features">Features</a> |
	<a href="#getting-started">Getting Started</a> |
	<a href="#usage">Usage</a> |
	<a href="#faqs">FAQs</a> |
	<a href="#documentation">Documentation</a> |
	<a href="#contributing">Contributing</a> |
	<a href="#acknowledgements">Acknowledgements</a> 🥰
</h4>

<p align="center">
  <img alt="Demo" src="images/demo.gif">
</p>

---
	

## [Features][wiki-features-url]
Invocable actions, also known as dynamic actions, can be invoked from Flows, Processes and a common endpoint in the REST API. 

Salesforce administrators have the aforementioned declarative tools at their disposal, but currently only have a primitive ability to send emails. These custom Apex email actions provide the following additional capabilities:

- **Available anywhere [@invocable methods](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_annotation_InvocableMethod.htm) can be invoked.** Examples are Lightning Flow Builder and Process Builder.
- **Save as Activity.** Save a reference to the email as an activity feed item for a specified target object.
- **Flexible recipients.** In additional to "To" recipients, send carbon copies (CC) and/or blind carbon copies (BCC).
- **Lightning Email Templates.** Upgrade from Classic Email Templates to the newer Lightning Email Templates which allows global headers and footers.
- **Include attachments.**  Attach Document, ContentVersion, or Attachment items to the email.
- **Other options.** Control [other](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm#apex_Messaging_SingleEmailMessage_constructors) email options.


## [Getting Started][wiki-getting-started-url]

### [Prerequisites][wiki-prerequisites-url]

There are a few items you need to setup before installing:

1. You will need to [Enable Lightning Experience](https://trailhead.salesforce.com/en/content/learn/modules/lex_migration_introduction/lex_migration_introduction_administration) if you plan on using [Lightning Enhanced Letterheads and Email Templates](https://trailhead.salesforce.com/en/content/learn/projects/customize-an-org-to-support-a-new-business-unit/configure-an-email-letterhead-and-template).
2. You will need to [Enable My Domain](https://trailhead.salesforce.com/en/content/learn/modules/identity_login/identity_login_my_domain) if you plan on using [Lightning Enhanced Letterheads and Email Templates](https://trailhead.salesforce.com/en/content/learn/projects/customize-an-org-to-support-a-new-business-unit/configure-an-email-letterhead-and-template).

### [Install][wiki-install-url]

Deploy the actions:

<a style="margin-right: 40%;" href="https://githubsfdeploy.herokuapp.com?owner=paull10au&repo=qsyd_InvocableEmailActions&ref=master">
  <img align="right" alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

1. Click the "Deploy to Salesforce" button.
2. Select the Org Type (Production / Sandbox).
3. Login to your Org.
4. Deploy the code.


## [Usage][wiki-usage-url]

There are 2 actions included

- QSyd - Invocable Email Action
- QSyd - Invocable Email Template Action

The latter is intentionally opinionated for exclusive use with a Lightning Email Template. The premise behind these actions is to expose the full capability of Salesforce emails, and as such the api is deliberately comprehensive.

To declaratively invoke these actions, do the following:

1. Load the Process Builder or Lightning Flow editor
2. Add an Action
3. Search for either **"QSyd - Invocable Email Action"** or **"QSyd - Invocable Email Template Action"**
4. Populate the required fields and 

### [QSyd - Invocable Email Action][github-qsyd_InvocableEmailAction-url]

The simplest use case for Process Builder:

<div>
	<img align="center" src="https://github.com/paull10au/qsyd_InvocableEmailActions/blob/master/images/qsyd_InvocableEmailAction_ProcessBuilder_parameters.png">
</div>

<br/>
<p>The simplest use case for Lightning Flow:</p>
<br/>

<div>
	<img align="center" src="https://github.com/paull10au/qsyd_InvocableEmailActions/blob/master/images/qsyd_InvocableEmailAction_Flow_parameters_1.png">
</div>
<div>
	<img align="center" src="https://github.com/paull10au/qsyd_InvocableEmailActions/blob/master/images/qsyd_InvocableEmailAction_Flow_parameters_2.png">
</div>

<br/>
<p>Example programmatic usage:</p>
<br/>

```apex
private static void given_requiredEmailParametersAreProvided_when_anEmailIsInstantiated_then_anEmailIsSent() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas@salesforce.com';
        param.ccAddress = 'test_email@gmail.com';
        param.bccAddress = 'test_email@gmail.com';
        param.throwExceptionForSendErrors = true;
        param.subject = 'Email Subject';
        param.bodyPlainText = 'Plain text body';
        param.bodyHtml = '<html><body><strong>Rich text body</strong></body></html>';
        param.charSet = 'utf-8';
        param.attachmentIds = CONTENTVERSION_EXAMPLES;
        param.whatId = CASE_EXAMPLE;
        param.parentMessageIds = INREPLYTO_EXAMPLE;
        param.orgWideEmailAddress = '';
        param.emailOptOutPolicy = 'FILTER';
        param.saveAsActivity = true;
        params.add(param);

        List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
        Integer invocations = Limits.getEmailInvocations();

        // Email was sent
        System.assertEquals(1, invocations);

        Test.stopTest();
    }
```

#### Supported options

<table>
  <tr><th>Option</th><th>Description</th></tr>
  <tr><td>NOT(<i>expression</i>)</td><td>Boolean negation, 1 (means true) if the expression is not zero</td></tr>
  <tr><td>IF(<i>condition</i>,<i>value_if_true</i>,<i>value_if_false</i>)</td><td>Returns one value if the condition evaluates to true or the other if it evaluates to false</td></tr>
  <tr><td>RANDOM()</td><td>Produces a random number between 0 and 1</td></tr>
  <tr><td>MIN(<i>e1</i>,<i>e2</i>, <i>...</i>)</td><td>Returns the smallest of the given expressions</td></tr>
  <tr><td>MAX(<i>e1</i>,<i>e2</i>, <i>...</i>)</td><td>Returns the biggest of the given expressions</td></tr>
  <tr><td>ABS(<i>expression</i>)</td><td>Returns the absolute (non-negative) value of the expression</td></tr>
  <tr><td>ROUND(<i>expression</i>,precision)</td><td>Rounds a value to a certain number of digits, uses the current rounding mode</td></tr>
  <tr><td>FLOOR(<i>expression</i>)</td><td>Rounds the value down to the nearest integer</td></tr>
  <tr><td>CEILING(<i>expression</i>)</td><td>Rounds the value up to the nearest integer</td></tr>
  <tr><td>LOG(<i>expression</i>)</td><td>Returns the natural logarithm (base e) of an expression</td></tr>
  <tr><td>LOG10(<i>expression</i>)</td><td>Returns the common logarithm (base 10) of an expression</td></tr>
  <tr><td>SQRT(<i>expression</i>)</td><td>Returns the square root of an expression</td></tr>
  <tr><td>SIN(<i>expression</i>)</td><td>Returns the trigonometric sine of an angle (in degrees)</td></tr>
  <tr><td>COS(<i>expression</i>)</td><td>Returns the trigonometric cosine of an angle (in degrees)</td></tr>
  <tr><td>TAN(<i>expression</i>)</td><td>Returns the trigonometric tangens of an angle (in degrees)</td></tr>
  <tr><td>ASIN(<i>expression</i>)</td><td>Returns the angle of asin (in degrees)</td></tr>
  <tr><td>ACOS(<i>expression</i>)</td><td>Returns the angle of acos (in degrees)</td></tr>
  <tr><td>ATAN(<i>expression</i>)</td><td>Returns the angle of atan (in degrees)</td></tr>
  <tr><td>SINH(<i>expression</i>)</td><td>Returns the hyperbolic sine of a value</td></tr>
  <tr><td>COSH(<i>expression</i>)</td><td>Returns the hyperbolic cosine of a value</td></tr>
  <tr><td>TANH(<i>expression</i>)</td><td>Returns the hyperbolic tangens of a value</td></tr>
  <tr><td>RAD(<i>expression</i>)</td><td>Converts an angle measured in degrees to an approximately equivalent angle measured in radians</td></tr>
  <tr><td>DEG(<i>expression</i>)</td><td>Converts an angle measured in radians to an approximately equivalent angle measured in degrees</td></tr>
</table>


### [QSyd - Invocable Email Template Action][github-qsyd_InvocableEmailTemplateAction-url]

An example programmatic usage:
```
   @IsTest
    private static void given_requiredEmailParametersAreProvided_when_anEmailIsInstantiated_then_anEmailIsSent() {
        qsyd_InvocableEmailTemplateAction.InvocableEmailParam param = new qsyd_InvocableEmailTemplateAction.InvocableEmailParam();
        List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam>();

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas@salesforce.com';
        param.emailTemplate = 'Test Template';
        param.targetObjectId = CONTACT_EXAMPLE;
        params.add(param);

        List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailTemplateAction.sendEmail(params);
        Integer invocations = Limits.getEmailInvocations();

        // Assert an email was sent
        System.assertEquals(1, invocations);

        Test.stopTest();
    }
```

## [Documentation][wiki-url]

Read the [wiki][wiki-url] for documentation on Invocable Email Actions.

Read the [FAQs][wiki-faqs-url] answer common questions.


## [FAQs][wiki-faqs-url]

#### Does it work in Communities?
> Yes, but with the following caveats/Yes/No/NA

#### Does it work in Mobile?
> Yes, but with the following caveats/Yes/No/NA

#### Does it work with Person Accounts?
> Yes, but with the following caveats/Yes/No/NA

#### Does it support Internationalisation (i18n)?
> Yes, labels can be translated using [Salesforce Translation Workbench](https://help.salesforce.com/articleView?id=workbench_overview.htm&type=5)

#### Others?


## Contributing

See the list of [Contributors][contributors-url] who participated in this project.

If you would like to join these awesome people, please refer to [contributing.md](/contributing.md) for guidelines.

## Acknowledgements

Special thanks to:

- Q Branch Sydney for your continued support.
- The myriad of Solution Engineers that have requested for, used and provided feedback on this project. 


## License

[![License][license-shield]][license-url] Copyright © 2020 [Paul Lucas][author-url]


<!--- Images -->
[stars-shield]: https://img.shields.io/github/stars/paull10au/qsyd_InvocableEmailActions?style=flat-square&color=green
[forks-shield]: https://img.shields.io/github/forks/paull10au/qsyd_InvocableEmailActions?style=flat-square
[version-shield]: https://img.shields.io/github/tag/paull10au/qsyd_InvocableEmailActions?label=release&color=green
[downloads-shield]: https://img.shields.io/github/downloads/paull10au/qsyd_InvocableEmailActions/total?style=flat-square&color=violet
[issues-shield]: https://img.shields.io/github/issues-raw/paull10au/qsyd_InvocableEmailActions?style=flat-square&color=red
[license-shield]: https://img.shields.io/badge/License-MIT-yellow.svg

<!--- Urls -->
[repository-url]: https://github.com/paull10au/qsyd_InvocableEmailActions
[version-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Release-Notes
[downloads-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/releases
[issues-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/issues
[license-url]: http://opensource.org/licenses/MIT
[author-url]: http://github.com/paull10au
[contributors-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/contributors

[wiki-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki
[wiki-features-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Features
[wiki-getting-started-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Getting-Started
[wiki-prerequisites-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Prerequisites
[wiki-install-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Install
[wiki-usage-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Usage
[wiki-faqs-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/wiki/Frequently-Asked-Questions

[github-qsyd_InvocableEmailAction-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/blob/master/src/classes/qsyd_InvocableEmailAction.cls
[github-qsyd_InvocableEmailTemplateAction-url]: https://github.com/paull10au/qsyd_InvocableEmailActions/blob/master/src/classes/qsyd_InvocableEmailTemplateAction.cls
