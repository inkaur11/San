/************************************************************************************
Apex Class Name     : ACG_CaseTriggerHandler
Created Date        : 16th Aug 2021
Function            : Handler Class for Case Trigger. 
Author              : Deloitte Consulting 
*************************************************************************************/
public without sharing class ACG_CaseTriggerHandler {
    
    //Handler Method for Before Insert.
    public void beforeInsert(List<sObject> newItems) {    
    
    }
    
    //Handler Method for Before Delete.    
    public void beforeDelete(Map<Id, sObject> oldItems) {
               
    }
    //Handler method for After Insert.
    public void afterInsert(Map<Id, sObject> newItems) {
     
    }
    
    //Handler method for After Update.    
    public void afterUpdate(Map<Id, sObject> newItems, Map<Id, sObject> oldItems) {
    	
    }
    
    //Handler method for After Delete    
    public void afterDelete(Map<Id, sObject> oldItems) {
    
    }

    //Handler method for After Undelete.
    public void afterUndelete(Map<Id, sObject> oldItems) {
    }   
}