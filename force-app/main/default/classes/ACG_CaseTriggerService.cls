/************************************************************************************
Apex Class Name     : ACG_CaseTriggerService
Created Date        : 16th August 2021
Function            : Service Class for ACG_CaseTrigger. 
Author              : Deloitte Consulting 
*************************************************************************************/

public without sharing class ACG_CaseTriggerService {
     /*
     * @description: To update ERS Cases to from 'New' ->'In Progress'(status) on first update.
     * @date: August 16, 2021
     * @param1: newMap -> newly updated records
     * @param2: oldMap -> old records
     * @author: Tarun Singh (tbondili@acg.aaa.com)
     */ 
    public static void updateStatus(List<Case> newList, Map<Id, Case> oldMap){        
        
    }
}