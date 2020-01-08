/**
 *      
     Author:         Paul Lucas
     Company:        Salesforce
     Description:    qsyd_InvocableEmailResult
     Date:           20-Apr-2018
    
     History:
     When           Who                 What
    
     TODO:
 */

public with sharing class qsyd_InvocableEmailResult {
    @InvocableVariable
    @AuraEnabled
    public List<String> results;

    @InvocableVariable
    @AuraEnabled
    public Boolean success;

    public qsyd_InvocableEmailResult(List<String> errors) {

        this.results = errors;
        this.success = errors.isEmpty();
    }
}