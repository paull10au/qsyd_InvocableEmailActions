/**
 *      
     Author:        Paul Lucas
     Company:       Salesforce
     Description:   qsyd_InvocableEmailBase - Base class for invocable methods wanting to calling the Messaging.sendEmail API

     Date:          28-Apr-2018

     Reference:     https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_messaging.htm
                    https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm

     Usage:         Assign execution authority for the profiles which will be executing the process builders or flows executing this class.

     History:
     When           Who                 What

 */

global virtual with sharing class qsyd_InvocableEmailBase {

    /**
     * Private members
     */
    private static List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
    private static Messaging.SingleEmailMessage emailMessage;
    private static Boolean throwExceptionForSendErrors = true;

    // Statically initialized logic
    static {
    }

    /**
     * Instantiate a new email message
     *
     */
    public static void newEmailMessage(Boolean throwException) {
        emailMessage = new Messaging.SingleEmailMessage();
        emailMessages.add(emailMessage);
        throwExceptionForSendErrors = throwExceptionForSendErrors && throwException;
    }

    /**
     * A list of email addresses or object IDs of the contacts, leads, and users you’re sending the email to.
     * The maximum number of email addresses allowed is 100.
     *
     * @param toAddresses
     */
    public static void setToAddresses(List<String> toAddresses) {
        toAddresses = normalizeList(toAddresses);

        if (!listIsNullOrEmpty(toAddresses)) {
            emailMessage.setToAddresses(new List<String>(toAddresses));
        }
    }

    /**
     * A list of carbon copy (CC) addresses or object IDs of the contacts, leads, and users you’re sending the email to.
     * The maximum allowed is 25.
     *
     * @param ccAddresses
     */
    public static void setCcAddresses(List<String> ccAddresses) {
        ccAddresses = normalizeList(ccAddresses);

        if (!listIsNullOrEmpty(ccAddresses)) {
            emailMessage.setCcAddresses(ccAddresses);
        }
    }

    /**
     * A list of blind carbon copy (BCC) addresses or object IDs of the contacts, leads, and users you’re sending the email to.
     * The maximum allowed is 25.
     *
     * @param bccAddresses
     */
    public static void setBccAddresses(List<String> bccAddresses) {
        bccAddresses = normalizeList(bccAddresses);

        if (!listIsNullOrEmpty(bccAddresses)) {
            emailMessage.setBccAddresses(bccAddresses);
        }
    }

    /**
     * The email subject line. If you are using an email template, the subject line of the template overrides this value.
     *
     * @param subject
     */
    public static void setSubject(String subject) {
        if (!String.isBlank(subject)) {
            emailMessage.setSubject(subject);
        }
    }

    /**
     * The text version of the email, specified by the sender. You must specify a value for setTemplateId, setHtmlBody,
     * or setPlainTextBody. Or, you can define both setHtmlBody and setPlainTextBody.
     *
     * @param plainTextBody
     */
    public static void setPlainTextBody(String plainTextBody) {
        if (!String.isBlank(plainTextBody)) {
            emailMessage.setPlainTextBody(plainTextBody);
        }
    }

    /**
     * The HTML version of the email, specified by the sender. The value is encoded according to the specification associated
     * with the organization. You must specify a value for setTemplateId, setHtmlBody, or setPlainTextBody.
     * Or, you can define both setHtmlBody and setPlainTextBody.
     *
     * @param htmlBody
     */
    public static void setHtmlBody(String htmlBody) {
        if (!String.isBlank(htmlBody)) {
            emailMessage.setHtmlBody(htmlBody);
        }
    }

    /**
     * The character set for the email. If this value is null, the user's default value is used.
     *
     * @param characterSet
     */
    public static void setCharset(String characterSet) {
        if (!String.isBlank(characterSet)) {
            emailMessage.setCharset(characterSet);
        }
    }

    /**
     * Array of IDs of Document, ContentVersion, or Attachment items to attach to the email.
     *
     * @param ids
     */
    public static void setEntityAttachments(List<String> ids) {
        if (!listIsNullOrEmpty(ids)) {
            emailMessage.setEntityAttachments(ids);
        }
    }

    /**
     * Array containing the file names of the binary and text files you want to attach to the email.
     *
     * @param fileNames
     */
    public static void setFileAttachments(List<Messaging.EmailFileAttachment> fileNames) {
        if (!listIsNullOrEmpty(fileNames)) {
            emailMessage.setFileAttachments(fileNames);
        }
    }

    /**
     * The References field of the outgoing email. Identifies an email thread. Contains the parent emails' References and message IDs, and possibly the In-Reply-To fields.
     *
     * @param references
     */
    public static void setReferences(String references) {
        if (!String.isBlank(references)) {
            emailMessage.setReferences(references);
        }
    }

    /**
     * Sets the optional emailOptOutPolicy. If you added recipients by ID instead of email address and the Email Opt Out option is set, this method determines the behavior of the sendEmail() call.
     * If you add recipients by their email addresses, the opt-out settings for those recipients aren’t checked and those recipients always receive the email.
     *
     * Possible values of the emailOptOutPolicy parameter are:
     *  -  SEND: (default) The email is sent to all recipients. The recipients’ Email Opt Out setting is ignored. The setting Enforce email privacy settings is ignored.
     *  -  FILTER: No email is sent to recipients that have the Email Opt Out option set. Emails are sent to the other recipients. The setting Enforce email privacy settings is ignored.
     *  -  REJECT: If any of the recipients have the Email Opt Out option set, sendEmail() throws an error and no email is sent.
     *             The setting Enforce email privacy settings is respected, as are the selections in the data privacy record based on the Individual object.
     *             If any of the recipients have Don’t Market, Don’t Process, or Forget this Individual selected, sendEmail() throws an error and no email is sent.
     *
     * @param emailOptOutPolicy
     */
    public static void setOptOutPolicy(String emailOptOutPolicy) {
        if (!String.isBlank(emailOptOutPolicy)) {
            emailMessage.setOptOutPolicy(emailOptOutPolicy.toUpperCase());
        }
    }

    /**
     * Sets the optional In-Reply-To field of the outgoing email. This field identifies the email or emails to which this email is a reply (parent emails).
     *
     * @param parentIds
     */
    public static void setInReplyTo(String parentIds) {
        if (!String.isBlank(parentIds)) {
            emailMessage.setInReplyTo(parentIds);
        }
    }

    /**
     * Sets the optional organization-wide email address associated with the outgoing email. The object's DisplayName field cannot be set if the setSenderDisplayName field is already set.
     *
     * @param emailAddressId
     */
    public static void setOrgWideEmailAddressId(Id emailAddressId) {
        if (!String.isBlank(emailAddressId) &&
                emailAddressId.getSobjectType() == Schema.OrgWideEmailAddress.SObjectType) {
            emailMessage.setOrgWideEmailAddressId(emailAddressId);
        }
    }

    /**
     * Sets the optional organization-wide email address associated with the outgoing email. The object's DisplayName field cannot be set if the setSenderDisplayName field is already set.
     *
     * @param emailAddressId
     */
    public static void setOrgWideEmailAddressId(String emailAddressId) {
        Id emailAddressId2;

        if (!String.isBlank(emailAddressId) &&
                emailAddressId.trim() instanceOf Id) {
            emailAddressId2 = Id.valueOf(emailAddressId);
            setOrgWideEmailAddressId(emailAddressId2);
        }
    }

    /**
     * If set to true, the subject, plain text, and HTML text bodies of the email are treated as template data.
     * The merge fields are resolved using the renderEmailTemplate method.
     *
     * Default is false.
     *
     * @param treatAsTemplate
     */
    public static void setTreatBodiesAsTemplate(Boolean treatAsTemplate) {
        if (treatAsTemplate != null) {
            emailMessage.setTreatBodiesAsTemplate(treatAsTemplate);
        }
    }

    /**
     * If set to true, the targetObjectId (a contact, lead, or user) is the recipient of the email.
     * If set to false, the targetObjectId is supplied as the WhoId field for template rendering but isn’t a recipient of the email.
     *
     * Default is true.
     *
     * @param treatAsRecipient
     */
    public static void setTreatTargetObjectAsRecipient(Boolean treatAsRecipient) {
        if (treatAsRecipient != null) {
            emailMessage.setTreatTargetObjectAsRecipient(treatAsRecipient);
        }
    }

    /**
     * Required if using a template, optional otherwise. The ID of the template used to create the email.
     *
     * @param emailTemplateId
     */
    public static void setTemplateId(String emailTemplateId) {
        if (!String.isBlank(emailTemplateId)) {
            emailMessage.setTemplateId(emailTemplateId);
        }
    }

    /**
     * Required if using a template, optional otherwise. The ID of the contact, lead, or user to which the email will be sent.
     * The ID you specify sets the context and ensures that merge fields in the template contain the correct data.
     *
     * @param targetObjectId
     */
    public static void setTargetObjectId(String targetObjectId) {
        if (!String.isBlank(targetObjectId)) {
            emailMessage.setTargetObjectId(targetObjectId);
        }
    }

    /**
     * If you specify a contact for the targetObjectId field, you can specify an optional whatId as well.
     * This helps to further ensure that merge fields in the template contain the correct data.
     *
     * @param whatId
     */
    public static void setWhatId(String whatId) {
        if (!String.isBlank(whatId)) {
            emailMessage.setWhatId(whatId);
        }
    }

    /**
     * This argument only applies if the recipient list is based on targetObjectId or targetObjectIds.
     * If HTML email tracking is enabled for the organization, you will be able to track open rates.
     *
     * Default is true.
     *
     * @param saveAsActivity
     */
    public static void saveAsActivity(Boolean saveAsActivity) {
        if (saveAsActivity != null) {
            emailMessage.setSaveAsActivity(saveAsActivity);
        }
    }

    /**
     * Indicates whether the email includes an email signature if the user has one configured.
     *
     * Default is true.
     *
     * @param setUseSignature
     */
    public static void setUseSignature(Boolean useSignature) {
        if (useSignature != null) {
            emailMessage.setUseSignature(useSignature);
        }
    }

    /**
     * Send a list of tracked emails.
     *
     * @param emailMessages
     * @param allOrNothing
     *
     * @return
     */
    public static List<qsyd_InvocableEmailResult> send(List<Messaging.SingleEmailMessage> emailMessages, Boolean allOrNothing) {
        List<Messaging.SendEmailResult> sendEmailResults = new List<Messaging.SendEmailResult>();
        List<qsyd_InvocableEmailResult> trackedEmailResults = new List<qsyd_InvocableEmailResult>();
        String errorMessage;
        List<String> errors = new List<String>();
        Integer i = 1;

        try {

            // Check that at least 1 recipient has been added
            for (Messaging.SingleEmailMessage message : emailMessages) {
                hasRecipient(message);
            }

            // Send the email(s)
            sendEmailResults = Messaging.sendEmail(emailMessages, allOrNothing);

            if (!sendEmailResults.isEmpty()) {
                for (Messaging.SendEmailResult result : sendEmailResults) {

                    // For each unsuccessful email result
                    if (!result.isSuccess()) {
                        errorMessage = '(' + i + ') : ';

                        for (Messaging.SendEmailError error : result.getErrors()) {
                            // Aggregate error fields
                            errorMessage += error.getStatusCode() + ' : ' + error.getMessage() + ', ';
                        }

                        errors.add(errorMessage.trim().removeEnd(','));
                    }
                    i++;
                }

                trackedEmailResults.add(new qsyd_InvocableEmailResult(errors));

                // Throw an exception containing the send errors rather than returning as output variables
                if (throwExceptionForSendErrors && !trackedEmailResults[0].success) {
                    throw new InvocableEmailException(String.valueOf(trackedEmailResults[0].results));
                }
            }

            // Truncate emails once they have been sent
            emailMessages.clear();

            return trackedEmailResults;
        } catch (Exception e) {

            // (Re)-throw error
            throw new InvocableEmailException('>>> Exception executing qsyd_InvocableEmailBase.send: ' + e.getMessage());
        }
    }

    /**
     * Send a tracked email
     *
     * @param send
     *
     * @return
     */
    public static List<qsyd_InvocableEmailResult> send(Boolean allOrNothing) {
        return send(emailMessages, allOrNothing);
    }

    /**
     * True if a recipient has been added
     *
     * @param hasRecipient
     */
    private static Boolean hasRecipient(Messaging.SingleEmailMessage message) {

        if (listIsNullOrEmpty(message.toAddresses) &&
                listIsNullOrEmpty(message.ccAddresses) &&
                listIsNullOrEmpty(message.bccAddresses) &&
                String.isBlank(message.targetObjectId)
                ) {
            throw new InvocableEmailException('Recipient not provided. Please provide at least one of the following: toAddress, ccAddress, bccAddress, targetObjectId');
        }

        return true;
    }

    /**
     * Remove duplicates and nulls from a list of strings
     *
     * @param normalizeList
     */
    private static List<String> normalizeList(List<String> recordList) {
        Set<String> normalSet = new Set<String>(recordList);

        normalSet.remove('null');
        normalSet.remove(null);

        return new List<String>(normalSet);
    }

    /**
     * True if list is null or empty
     *
     * @param listIsNullOrEmpty
     */
    private static Boolean listIsNullOrEmpty(List<Object> recordList) {

        if (recordList != null && !recordList.isEmpty()) {
            return false;
        }

        return true;
    }

    /**
     * Send tracked email parameters
     */
    global abstract class InvocableEmailParamBase {

        /**
         * Return a list from a comma delimited string
         *
         * @param stringToList
         */
        public List<String> stringToList(String delimitedString) {

            return String.isBlank(delimitedString) ? new List<String>() : (delimitedString + ',').split(',');
        }

        /**
         * Return null if value is null or empty, else return trimmed value
         *
         * @return
         */
        public String nullOrTrim(String value) {

            return String.isBlank(value) ? null : value.trim();
        }

        /**
         * Throw exception if value is null or empty
         *
         * @return
         */
        public void throwIfBlank(String value, String exceptionMessage) {

            if (String.isBlank(value)) {
                throw new InvocableEmailException(exceptionMessage);
            }
        }

        /**
         * Find the org wide email address id for a pre-verified email address
         *
         * @return
         */
        public String getOrgWideAddressId(String emailAddress) {
            List<OrgWideEmailAddress> emails;

            if (String.isBlank(emailAddress)) {
                return '';
            }

            // Find an org wide email address
            emails = [
                    SELECT Id
                    FROM OrgWideEmailAddress
                    WHERE Address = :emailAddress
            ];

            // Error if no matching record was found
            if (emails.isEmpty()) {

                throw new InvocableEmailException(String.format('{0}{1}{2}', new List<String>{
                        '\'', emailAddress, '\' has not been configured in Organization-Wide Addresses.'
                }));
            }

            return emails[0].Id;
        }

        /**
         * True if "id" is in the form of objectType id
         *
         * @return
         */
        public Boolean isIdInstanceOfSObjectType(String id, SObjectType objectType) {

            return (!String.isBlank(id) && id.trim() instanceOf Id && ((Id) id.trim()).getSobjectType() == objectType);
        }
    }

    /**
     * Invocable email exception
     */
    global class InvocableEmailException extends Exception {
    }
}