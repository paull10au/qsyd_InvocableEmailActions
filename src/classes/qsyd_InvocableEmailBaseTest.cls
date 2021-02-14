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
    static String orgWideEmailAddress;

    @TestSetup
    private static void setupTestData() {
    }

    @IsTest
    private static void initialiseSetupTestData() {

        // Attempt to get an org wide email address
        orgWideEmailAddress = [
                SELECT Address
                FROM OrgWideEmailAddress
                LIMIT 1
        ]?.Id;
    }

    @IsTest
    private static void given_staticMethodsAreCalled_when_parametersArePassed_then_parametersArePassedThrough() {

        initialiseSetupTestData();

        Test.startTest();

        qsyd_InvocableEmailBase.newEmailMessage(false);
        qsyd_InvocableEmailBase.setFileAttachments(new List<Messaging.EmailFileAttachment>());
        qsyd_InvocableEmailBase.setReferences('example email thread reference');
        qsyd_InvocableEmailBase.setOrgWideEmailAddressId(orgWideEmailAddress);

        Test.stopTest();
    }

}