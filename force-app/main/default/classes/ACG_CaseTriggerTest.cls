/*
* @description: Test class for ACG_CaseTrigger
* @date: August 16, 2021
* author: Deloitte USI
*/

@isTest
public class ACG_CaseTriggerTest {
    @isTest
    public static void updateStatusTest(){
        //Test data Record
        Case caseRec = [SELECT Id FROM Case  LIMIT 1];
		system.debug('caseRec'+caseRec);
    }
}