<img align="right" width="130" src="https://qbranch-sydney.s3-ap-southeast-2.amazonaws.com/qbranch_logo.gif">

# Invocable Email Actions 

![stars-badge] ![forks-badge] ![downloads-badge] ![issues-badge]

#### Apex email actions available for Process Builder and Lightning Flow Builder leveraging the <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm">SingleEmailMessage Class.</a>

		
<h4 align="center">
	<a href="#overview">Overview</a> |
	<a href="#installation-instructions">Installation</a> |
	<a href="#how-it-works">How it Works</a> |
	<a href="#faqs">FAQs</a> |
	<a href="#contributing">Contribute</a>
</h4>

<p align="center">
  <img alt="Demo" src="images/demo.gif">
</p>

---
	

## Overview
Invocable actions, also known as dynamic actions, can be invoked from Flows, Processes and a common endpoint in the REST API. 

Salesforce administrators have the aforementioned declarative tools at their disposal, but currently only have a primitive ability to send emails. These custom Apex email actions provide the following additional capabilities:

- **Available anywhere [@invocable methods](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_annotation_InvocableMethod.htm) can be invoked.** Examples are Lightning Flow Builder and Process Builder.
- **Save as Activity.** Save a reference to the email as an activity feed item for a specified target object.
- **Flexible recipients.** In additional to "To" recipients, send carbon copies (CC) and/or blind carbon copies (BCC).
- **Lightning Email Templates.** Upgrade from Classic Email Templates to the newer Lightning Email Templates which allows global headers and footers.
- **Include attachments.**  Attach Document, ContentVersion, or Attachment items to the email.
- **Other options.** Control [other](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm#apex_Messaging_SingleEmailMessage_constructors) email options.


## Installation Instructions
<a style="margin-right: 40%;" href="https://githubsfdeploy.herokuapp.com?owner=paull10au&repo=qsyd_InvocableEmailActions&ref=master">
  <img align="right" alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

1. Click the "Deploy to Salesforce" button.
2. Select the org type.
3. Authenticate using OAuth.


## FAQs

#### Does it work in Communities?
Yes, but with the following caveats/Yes/No/NA

#### Does it work in Mobile?
Yes, but with the following caveats/Yes/No/NA

#### Does it work with Person Accounts?
Yes, but with the following caveats/Yes/No/NA

#### Does it support Internationalisation (i18n)?
Yes, labels can be translated using [Salesforce Translation Workbench](https://help.salesforce.com/articleView?id=workbench_overview.htm&type=5)

#### Others?


## Contributing

Refer to [contributing.md](/contributing.md).


## License

[MIT][mit] © [Paul Lucas][author]

[stars-badge]: https://img.shields.io/github/stars/paull10au/qsyd_InvocableEmailActions?style=flat-square&color=green
[forks-badge]: https://img.shields.io/github/forks/paull10au/qsyd_InvocableEmailActions?style=flat-square
[downloads-badge]: https://img.shields.io/github/downloads/paull10au/qsyd_InvocableEmailActions/total?style=flat-square
[issues-badge]:	https://img.shields.io/github/issues-raw/paull10au/qsyd_InvocableEmailActions?style=flat-square

[mit]: http://opensource.org/licenses/MIT
[author]: http://github.com/paull10au
