/**
 *      
     Author:         Paul Lucas
     Company:        Salesforce
     Description:    qsyd_InvocableEmailBaseTest
     Date:           18-Nov-2018

     History:
     When           Who                 What

     TODO:
 */

@IsTest
public with sharing class qsyd_InvocableEmailBaseTest {

    private static final String ACCOUNT = 'Account';
    private static final String CONTACT = 'Contact';
    private static final String USER = 'User';



    private static final String CASE_EXAMPLE = '5004P00000XFXikQAH';
    private static final String EMAIL_EXAMPLE = '02s4P00000hQIpzQAG';
    private static final String ORGWIDEEMAILADDRESS_EXAMPLE = '0D24P000002AHEMSA4';


    @TestSetup
    private static void setupTestData() {
    }

    @IsTest
    private static void initialiseSetupTestData() {

    }

    @IsTest
    private static void given_staticMethodsAreCalled_when_parametersArePassed_then_parametersArePassedThrough() {

        initialiseSetupTestData();

        Test.startTest();

        qsyd_InvocableEmailBase.newEmailMessage(false);
        qsyd_InvocableEmailBase.setFileAttachments(new List<Messaging.EmailFileAttachment>());
        qsyd_InvocableEmailBase.setReferences('example email thread reference');
        qsyd_InvocableEmailBase.setOrgWideEmailAddressId(ORGWIDEEMAILADDRESS_EXAMPLE);

        Test.stopTest();
    }

}