/**
     Author:         Paul Lucas
     Company:        Salesforce
     Description:    qsyd_InvocableEmailActionTest
     Date:           18-Nov-2018
    
     History:
     When           Who                 What
    
     TODO:
 */

@IsTest
public with sharing class qsyd_InvocableEmailActionTest {

    private static final String ACCOUNT = 'Account';
    private static final String CONTACT = 'Contact';
    private static final String USER = 'User';
    private static final String INREPLYTO_EXAMPLE = 'topic/2734@dsalesforce.com';

    static Account testAccount;
    static Case testCase;
    static ContentVersion testContentVersion;

    @TestSetup
    private static void setupTestData() {
        // Account
        testAccount = new Account(Name = 'Test Account');
        INSERT testAccount;

        // Case
        testCase = new Case(Subject = 'Test Case');
        INSERT testCase;

        // Content
        testContentVersion = new ContentVersion(Title = 'Test Content', PathOnClient = 'TestContent.pdf', VersionData = Blob.valueOf('Test Content'), IsMajorVersion = true);
        INSERT testContentVersion;
    }

    @IsTest
    private static void initialiseSetupTestData() {
        testAccount = [
                SELECT Id
                FROM Account
                LIMIT 1
        ][0];

        testCase = [
                SELECT Id
                FROM Case
                LIMIT 1
        ][0];

        testContentVersion = [
                SELECT Id
                FROM ContentVersion
                LIMIT 1
        ][0];
    }

    @IsTest
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
        param.attachmentIds = testContentVersion.Id;
        param.whatId = testCase.Id;
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

    @IsTest
    private static void given_noRecipientsAreProvided_when_anEmailIsInstantiated_then_anExceptionIsThrown() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.bodyPlainText = 'plain text body';
        params.add(param);

        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }

        // Exception was thrown
        System.assertEquals(1, exceptions);

        Test.stopTest();
    }

    @IsTest
    private static void given_anOrgWideEmailAddressDoesNotExist_when_anOrgWideEmailIsQueried_then_anExceptionIsThrown() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas@salesforce.com';
        param.bodyPlainText = 'plain text body';
        param.orgWideEmailAddress = 'non_existent_email@salesforce.com';
        params.add(param);

        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);

            System.debug(results);
        } catch (Exception e) {
            exceptions++;
        }

        // Exception was thrown
        System.assertEquals(1, exceptions);

        Test.stopTest();
    }

    @IsTest
    private static void given_anInvalidEmailIsSupplied_when_anEmailIsInstantiated_then_anEmailIsSentWithErrors() {
        qsyd_InvocableEmailAction.InvocableEmailParam param = new qsyd_InvocableEmailAction.InvocableEmailParam();
        List<qsyd_InvocableEmailAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas';
        param.bodyPlainText = 'plain text body';
        params.add(param);

        try {
            List<qsyd_InvocableEmailResult> results = qsyd_InvocableEmailAction.sendEmail(params);
        } catch (Exception e) {
            exceptions++;
        }

        // Exception was thrown
        System.assertEquals(1, exceptions);

        Test.stopTest();
    }
}