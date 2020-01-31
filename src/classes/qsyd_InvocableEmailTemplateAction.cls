/**
     Author:        Paul Lucas
     Company:       Salesforce
     Description:   qsyd_InvocableEmailTemplateAction - Lightning Flow and Process Builder invocable action calling the Messaging.sendEmail API enabling a template based messages.
                    Optionally allows tracking of sent emails.

     Date:          25-Apr-2018
     Reference:     https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_email_outbound_single.htm
     Test Class:    qsyd_InvocableEmailTemplateActionTest

     Usage:         Refer to qsyd_InvocableEmailTemplateActionTest methods
     History:
     When           Who                 What

     TODO:
        - Use custom labels for error messages
 */

global with sharing class qsyd_InvocableEmailTemplateAction extends qsyd_InvocableEmailBase {

    /**
     * sendEmail: Send Email using a Template
     *
     * @param params
     *
     * @return
     *
     */
    @InvocableMethod(label='QSyd - Invocable Email Template Action' description='Invoke Messaging.sendEmail to send a template based message')
    public static List<qsyd_InvocableEmailResult> sendEmail(List<InvocableEmailParam> params) {
        List<qsyd_InvocableEmailResult> results = new List<qsyd_InvocableEmailResult>();

        for (InvocableEmailParam invocableEmailParameters : params) {

            // Construct an email message instance, establish if send exceptions should be thrown to caller.
            newEmailMessage(invocableEmailParameters.throwException);

            // Set recipients
            setTargetObjectId(invocableEmailParameters.targetObject);
            setToAddresses(invocableEmailParameters.toAddresses);
            setCcAddresses(invocableEmailParameters.ccAddresses);
            setBccAddresses(invocableEmailParameters.bccAddresses);

            // Set message properties
            setTemplateId(invocableEmailParameters.emailTemplateId);
            setCharset(invocableEmailParameters.characterSet);
            setEntityAttachments(invocableEmailParameters.attachments);
            setTreatBodiesAsTemplate(invocableEmailParameters.treatAsTemplate);
            setTreatTargetObjectAsRecipient(invocableEmailParameters.treatAsRecipient);

            // Set email properties
            setWhatId(invocableEmailParameters.what);
            setInReplyTo(invocableEmailParameters.parentMessages);
            setOptOutPolicy(invocableEmailParameters.optOutPolicy);
            setOrgWideEmailAddressId(invocableEmailParameters.orgWideEmailAddressId);
            saveAsActivity(invocableEmailParameters.saveEmailAsActivity);
            setUseSignature(invocableEmailParameters.useUserSignature);
        }

        try {
            results = send(false);
        } catch (Exception e) {
            throw new InvocableEmailException('>>> qsyd_InvocableEmailTemplateAction.sendEmail failed with exception: ' + e.getMessage());
        }

        return results;
    }

    /**
     * Extend invocable email parameters
     */
    global class InvocableEmailParam extends InvocableEmailParamBase {
        @InvocableVariable(label='Recipient To Addresses, Max 100, Comma Delimited' description='Recipient To addresses' required=false)
        global String toAddress;

        @InvocableVariable(label='Recipient Cc Addresses, Max 25, Comma Delimited' description='Recipient Cc addresses' required=false)
        global String ccAddress;

        @InvocableVariable(label='Recipient Bcc Addresses, Max 25, Comma Delimited' description='Recipient Bcc addresses' required=false)
        global String bccAddress;

        @InvocableVariable(label='Email Character Set' description='Email character set' required=false)
        global String charSet;

        @InvocableVariable(label='Attachment Ids' description='Comma delimited list of ids of Document, ContentVersion, or Attachment' required=false)
        global String attachmentIds;

        @InvocableVariable(label='Email Template Id or Name' description='Id, Name, or Developer Name of Email Template' required=true)
        global String emailTemplate;

        @InvocableVariable(label='Target Object Id - Contact, Lead or User Id' description='The Id of the contact, lead, or user to which the email will be sent.' required=true)
        global String targetObjectId;

        @InvocableVariable(label='What Id - If you specify a Contact Id, either an Account, Asset, Campaign, Case, Contract, Opportunity, Order, Product, Solution, Custom' description='If you specify a contact for the targetObjectId field, you can specify an optional whatId as well. Must be either a Account, Asset, Campaign, Case, Contract, Opportunity, Order, Product, Solution, Custom' required=false)
        global String whatId;

        @InvocableVariable(label='Parent Message Id ' description='This field identifies the email or emails to which this email is a reply (parent emails).' required=false)
        global String parentMessageIds;

        @InvocableVariable(label='Email Opt Out Policy' description='If you added recipients by ID instead of email address and the Email Opt Out option is set, this method determines the behavior of the sendEmail() call.' required=false)
        global String emailOptOutPolicy;

        @InvocableVariable(label='Org Wide Email Address' description='The associated org wide email address set up in Organization-Wide Addresses' required=false)
        global String orgWideEmailAddress;

        @InvocableVariable(label='Save as Activity?' description='This argument only applies if the recipient list is based on targetObjectId or targetObjectIds. If HTML email tracking is enabled for the organization, you will be able to track open rates.' required=false)
        global Boolean saveAsActivity;

        @InvocableVariable(label='Use Signature?' description='Indicates whether the email includes an email signature if the user has one configured.' required=false)
        global Boolean useSignature;

        @InvocableVariable(label='Treat Bodies as Template?' description='The subject, plain text, and HTML text bodies of the email are treated as template data. The merge fields are resolved using the renderEmailTemplate method.' required=false)
        global Boolean treatBodiesAsTemplate;

        @InvocableVariable(label='Treat Target Object as Recipient?' description='If set to true, the targetObjectId (a contact, lead, or user) is the recipient of the email. If set to false, the targetObjectId is supplied as the WhoId field for template rendering but isn’t a recipient of the email.' required=false)
        global Boolean treatTargetObjectAsRecipient;

        @InvocableVariable(label='Throw an Exception for Send Errors?' description='Throw an exception containing any send results errors. The default is true.' required=false)
        global Boolean throwExceptionForSendErrors;

        /**
         * To addresses property
         */
        public List<String> toAddresses {
            get {
                return stringToList(this.toAddress);
            }
            set {
            }
        }

        /**
         * Cc addresses property
         */
        public List<String> ccAddresses {
            get {
                return stringToList(this.ccAddress);
            }
            set {
            }
        }

        /**
         * Bcc addresses property
         */
        public List<String> bccAddresses {
            get {
                return stringToList(this.bccAddress);
            }
            set {
            }
        }

        /**
         * Character set property
         */
        public String characterSet {
            get {
                return nullOrTrim(this.charSet);
            }
            set {
            }
        }

        /**
         * Attachments property
         */
        public List<String> attachments {
            get {
                return stringToList(this.attachmentIds);
            }
            set {
            }
        }

        /**
         * Email template id property
         */
        public String emailTemplateId {
            get {
                throwIfBlank(this.emailTemplate, 'An email template id or name must be provided.');

                return this.isIdInstanceOfSObjectType(this.emailTemplate, Schema.EmailTemplate.SObjectType) ? emailTemplate.trim() : this.getTemplateId();
            }
            set {
            }
        }

        /**
         * Target object property
         */
        public String targetObject {
            get {
                return nullOrTrim(this.targetObjectId);
            }
            set {
            }
        }

        /**
         * What property
         */
        public String what {
            get {
                return nullOrTrim(this.whatId);
            }
            set {
            }
        }

        /**
         * Parent messages property
         */
        public String parentMessages {
            get {
                return nullOrTrim(this.parentMessageIds);
            }
            set {
            }
        }

        /**
         * Opt out policy property
         */
        public String optOutPolicy {
            get {
                return nullOrTrim(this.emailOptOutPolicy);
            }
            set {
            }
        }

        /**
         * Organization-wide email address id
         */
        public String orgWideEmailAddressId {
            get {
                return this.getOrgWideAddressId(nullOrTrim(this.orgWideEmailAddress));
            }
            set {
            }
        }

        /**
         * Save as activity property
         */
        public Boolean saveEmailAsActivity {
            get {
                return (this.isIdInstanceOfSObjectType(this.targetObjectId, Schema.User.SObjectType)) ? false : (this.saveAsActivity == null) ? true : this.saveAsActivity;
            }
            set {
            }
        }

        /**
         * Use signature property
         */
        public Boolean useUserSignature {
            get {
                return (this.useSignature == null) ? true : this.useSignature;
            }
            set {
            }
        }

        /**
         * Treat bodies as template property
         */
        public Boolean treatAsTemplate {
            get {
                return (this.treatBodiesAsTemplate == null) ? false : this.treatBodiesAsTemplate;
            }
            set {
            }
        }

        /**
         * targetObjectId source property
         */
        public Boolean treatAsRecipient {
            get {
                return (this.treatTargetObjectAsRecipient == null) ? true : this.treatTargetObjectAsRecipient;
            }
            set {
            }
        }

        /**
         * Throw exception for send errors property
         */
        public Boolean throwException {
            get {
                return (this.throwExceptionForSendErrors == null) ? true : this.throwExceptionForSendErrors;
            }
            set {
            }
        }

        /**
         * Find the most recently updated, active email template by either developer or display name
         *
         * @return
         */
        private String getTemplateId() {
            List<EmailTemplate> templates;
            String emailTemplateName = this.emailTemplate.trim();

            // Find a template
            templates = [
                    SELECT Id
                    FROM EmailTemplate
                    WHERE IsActive = TRUE
                    AND (DeveloperName = :emailTemplateName
                    OR Name = :emailTemplateName)
                    ORDER BY LastModifiedDate DESC
                    LIMIT 1
            ];

            // Error if no matching record was found
            if (templates.isEmpty()) {

                throw new InvocableEmailException(String.format('{0}{1}{2}', new List<String>{
                        '\'', emailTemplateName, '\' template does not exist.'
                }));
            }

            return templates[0].Id;
        }
    }
}