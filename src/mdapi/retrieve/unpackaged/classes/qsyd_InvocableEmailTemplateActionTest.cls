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

    private static final String CONTACT_EXAMPLE = '0034P00002PYwXAQA1';

    static EmailTemplate emailTemplate;

    @TestSetup
    private static void setupTestData() {

        // Insert an email template
        emailTemplate = new EmailTemplate(Body = 'Template body', Description = 'Test template', DeveloperName = 'TestTemplate', Name = 'Test Template', FolderId = UserInfo.getUserId(), TemplateType = 'text', IsActive = True);
        INSERT emailTemplate;

        System.debug('emailTemplate: ' + emailTemplate.Id);
    }

    @IsTest
    private static void initialiseSetupTestData() {
//        emailTemplate = [
//                SELECT Id
//                FROM EmailTemplate
//                WHERE DeveloperName = 'TestTemplate'
//                LIMIT 1
//        ][0];
    }

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

    @IsTest
    private static void given_anInvalidEmailIsSupplied_when_anEmailIsInstantiated_then_anEmailIsSentWithErrors() {
        qsyd_InvocableEmailTemplateAction.InvocableEmailParam param = new qsyd_InvocableEmailTemplateAction.InvocableEmailParam();
        List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam> params = new List<qsyd_InvocableEmailTemplateAction.InvocableEmailParam>();
        Integer exceptions = 0;

        initialiseSetupTestData();

        Test.startTest();

        param.toAddress = 'plucas';
        param.emailTemplate = 'Test Template';
        param.targetObjectId = CONTACT_EXAMPLE;
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
        param.targetObjectId = CONTACT_EXAMPLE;
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
        param.targetObjectId = CONTACT_EXAMPLE;
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