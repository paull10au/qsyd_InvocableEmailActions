/**
 *      
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

    private static final String CONTACT_EXAMPLE = '0034P00002PYwXAQA1';
    private static final String CONTENTVERSION_EXAMPLES = '0684P00000ARbLNQA1,0684P00000ARbLIQA1';
    private static final String CASE_EXAMPLE = '5004P00000XFXikQAH';
    private static final String EMAIL_EXAMPLE = '02s4P00000lnXqBQAU';
    private static final String INREPLYTO_EXAMPLE = 'topic/2734@dsalesforce.com';
    private static final String ORGWIDEEMAILADDRESS_EXAMPLE = '0D24P000002AHEMSA4';

    static Account testAccount;

    @TestSetup
    private static void setupTestData() {
        // Insert an account
        testAccount = new Account(Name = 'Test Account');
        INSERT testAccount;
    }

    @IsTest
    private static void initialiseSetupTestData() {

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