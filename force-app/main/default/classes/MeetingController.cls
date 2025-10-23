public with sharing class MeetingController {

    @AuraEnabled(cacheable=true)
    public static List<Meeting__c> getUpcomingMeetings(Id accountId) {
        return [
            SELECT Id, Name, Title__c, Start__c, End__c, Host__c, Participant__c
            FROM Meeting__c
            WHERE Account__c = :accountId
            AND Start__c >= TODAY
            ORDER BY Start__c ASC
        ];
    }

    @AuraEnabled
    public static Meeting__c createMeeting(
        Id accountId, 
        String title, 
        DateTime startDate, 
        DateTime endDate, 
        Id participantId, 
        Id hostId
    ) {
        Meeting__c m = new Meeting__c(
            Account__c = accountId,
            Title__c = title,
            Start__c = startDate,
            End__c = endDate,
            Participant__c = participantId,
            Host__c = hostId
        );
        insert m;
        return m;
    }
}
