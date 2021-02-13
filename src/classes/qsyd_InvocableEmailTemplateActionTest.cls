/**
 *      
     Author:         Paul Lucas
     Company:        Salesforce
     Description:    qsyd_InvocableEmailTemplateActionTest
     Date:           18-Dec-2019

     History:
     When           Who                 What

     TODO:
 */

@IsTest
public with sharing class qsyd_InvocableEmailTemplateActionTest {

    private static final String ACCOUNT = 'Account';
    private static final String CONTACT = 'Contact';
    private static final String USER = 'User';

    static EmailTemplate testEmailTemplate;
    static Contact testContact;
    static Account testAccount;

    @TestSetup
    private static void setupTestData() {
        User runningUser = [
                SELECT id
                FROM User
                WHERE Id = :UserInfo.getUserId()
        ];

        System.runAs (runningUser) {
            // Email Template
            testEmailTemplate = new EmailTemplate(Body = 'Template body', Description = 'Test template', DeveloperName = 'TestTemplate', Name = 'Test Template', FolderId = UserInfo.getUserId(), TemplateType = 'text', IsActive = True);
            INSERT testEmailTemplate;

            // Contact
            testContact = new Contact(FirstName = 'Paul', LastName = 'Lucas', Email = 'plucas@salesforce.com');
            INSERT testContact;

            // Account
            testAccount = new Account(Name = 'Test Account');
            INSERT testAccount;
        }
    }

    @IsTest
    private static void initialiseSetupTestData() {
        testContact = [
                SELECT Id
                FROM Contact
                LIMIT 1
        ][0];

        testEmailTemplate = [
                SELECT Id
                FROM EmailTemplate
                WHERE DeveloperName = 'TestTemplate'
                LIMIT 1
        ][0];
    }

    @IsTest
    private static void given_requiredEmailParametersAreProvided_when_anEmailIsInstantiated_then_anEmailIsSent() {
        qsyd_InvocableEmailTemplateAction.InvocableEmailParam param = new qsyd_InvocableEmailTemplateAction.InvocableEmailParam();
        List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam>();

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas@salesforce.com';
        param.emailTemplate = 'Test Template';
        param.targetObjectId = testContact.Id;

        params.add(param);

        List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailTemplateAction.sendEmail(params);
        Integer invocations = Limits.getEmailInvocations();

        // Assert an email was sent
        System.assertEquals(1, invocations);

        Test.stopTest();
    }

    @IsTest
    private static void given_anInvalidEmailIsSupplied_when_anEmailIsInstantiated_then_anEmailIsSentWithErrors() {
        qsyd_InvocableEmailTemplateAction.InvocableEmailParam param = new qsyd_InvocableEmailTemplateAction.InvocableEmailParam();
        List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas';
        param.emailTemplate = 'Test Template';
        param.targetObjectId = testContact.Id;
        params.add(param);

        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailTemplateAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }

        // Exception was thrown
        System.assertEquals(1, exceptions);

        Test.stopTest();
    }

    @IsTest
    private static void given_anInvalidTemplateIsSupplied_when_anEmailIsInstantiated_then_anExceptionIsThrown() {
        qsyd_InvocableEmailTemplateAction.InvocableEmailParam param = new qsyd_InvocableEmailTemplateAction.InvocableEmailParam();
        List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas@salesforce.com';
        param.emailTemplate = '';
        param.targetObjectId = testContact.Id;
        params.add(param);

        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailTemplateAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }

        // Exception was thrown
        System.assertEquals(1, exceptions);

        Test.stopTest();
    }

    @IsTest
    private static void given_anIncorrectEmailTemplateIsProvided_when_anEmailIsInstantiated_then_anExceptionIsThrown() {
        qsyd_InvocableEmailTemplateAction.InvocableEmailParam param = new qsyd_InvocableEmailTemplateAction.InvocableEmailParam();
        List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas@salesforce.com';
        param.emailTemplate = 'Incorrect Template';
        param.targetObjectId = testContact.Id;
        params.add(param);

        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailTemplateAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }

        // Exception was thrown
        System.assertEquals(1, exceptions);

        Test.stopTest();
    }
}