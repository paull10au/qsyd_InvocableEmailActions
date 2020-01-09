<img align="right" width="150" src="https://qbranch-sydney.s3-ap-southeast-2.amazonaws.com/qbranch_logo.gif">

# Invocable Email Actions
#### Apex email actions available for Process Builder and Lightning Flow Builder leveraging the <a href="https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm">SingleEmailMessage Class.</a>
	
<h4 align="center">
	<a href="#overview">Overview</a> |
	<a href="#installation-instructions">Installation</a> |
	<a href="#how-it-works">How it Works</a> |
	<a href="#faqs">FAQs</a> |
	<a href="#contributing">Contribute</a>
</h4>

<h3 align="center">
	<a>
    		<img alt="forks on github"
		src="https://img.shields.io/github/forks/paull10au/qsyd_InvocableEmailActions?style=flat-square&logoColor=blue">
  	</a>
  	<a>
    		<img alt="stars on github"
		src="https://img.shields.io/github/stars/paull10au/qsyd_InvocableEmailActions?style=flat-square">
  	</a>
  	<a>
    		<img alt="downloads on github"
		src="https://img.shields.io/github/downloads/paull10au/qsyd_InvocableEmailActions/total?style=flat-square">
  	</a>
  	<a>
    		<img alt="issues"
		src="https://img.shields.io/github/issues-raw/paull10au/qsyd_InvocableEmailActions?style=flat-square">
  	</a>
</h3>

<p align="center">
  <img alt="Demo" src="images/demo.gif">
</p>

---

## Table of Contents

<details>
<summary>Click to expand</summary>

- [About](#about)
- [Install](#install)
- [Usage](#usage)
  * [API](#api)
  * [Configuration Options](#configuration-options)
- [CLI Usage](#cli-usage)
- [Transforms](#transforms)
  * [CODE](#code)
  * [REMOTE](#remote)
  * [TOC](#toc)
- [Running Async transforms](#running-async-transforms)
- [🔌 Third Party Plugins](#%F0%9F%94%8C-third-party-plugins)
- [Adding Custom Transforms](#adding-custom-transforms)
- [Plugin Example](#plugin-example)
- [Other usage examples](#other-usage-examples)
- [Custom Transform Demo](#custom-transform-demo)
- [Prior Art](#prior-art)
- [License](#license)

</details>
	

## Overview
Invocable actions, also known as dynamic actions, can be invoked from Flows, Processes and a common endpoint in the REST API.  
- **Multi Object Support.** Plot related records to Lead, Account, Contact, Opportunity and Case.
- **Multi Language Support.** All labels and error messages as translatable custom labels.
- **Locale Support for Dates.** Date formats change based on your Salesforce locale setting.
- **3rd Party JS.** Demonstrates 3rd Party JS and Apex imperative callouts to populate data in an interactive timeline.
- **Responsive interface.** Uses flexipageRegionWidth to determine where in the page it is located.
- **Minimises server roundtrips.** Uses Lightning Data Service for tooltips and falls back to queried data when needed.

> This sample application is designed to run on Salesforce Platform. If you want to experience Lightning Web Components on any platform, please visit https://lwc.dev, and try out the Lightning Web Components sample application [LWC Recipes OSS](https://github.com/trailheadapps/lwc-recipes-oss).

## Installation Instructions

<a href="https://githubsfdeploy.herokuapp.com?owner=paull10au&repo=qsyd_InvocableEmailActions&ref=master">
  <img align="right" alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

1. Click the "Deploy to Salesforce" button
2. Select your Org type
3. Authenticate 

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
