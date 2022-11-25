public with sharing class OrderHelper {
    public OrderHelper() {}

    public static void calcFreight(List<Order> orderList) {
        Set<String> setIdOrders = new Set<String>();
        Set<String> DistributionCenterSetStateId = new Set<String>();
        Set<String> accountSetIdsCep = new Set<String>();
        Set<String> accountSetIdCity = new Set<String>();
        String freightSetInOrder;

        for (Order order : orderList) {
            setIdOrders.add(order.Id);
            System.debug(setIdOrders);
        }

        Map<Id, DistributionCenter__c> distributionCenterMap = new Map<Id, DistributionCenter__c> ([
            SELECT Id, Name, State__c
            FROM DistributionCenter__c
        ]);        

        for (DistributionCenter__c distributionCenter : distributionCenterMap.values()){
            DistributionCenterSetStateId.add(distributionCenter.State__c);
            System.debug(distributionCenter.Name + distributionCenter.State__c);
            System.debug(DistributionCenterSetStateId);
        }

        Map<Id, Account> accountMap = new Map<Id, Account>([
            SELECT Id, CEP__c, City__c
            FROM Account
        ]);

        for (Account account : accountMap.values()){
            accountSetIdsCep.add(account.CEP__c);
            accountSetIdCity.add(account.City__c);
        }

        Map<Id, Freight__c> freightMap = new Map<Id, Freight__c> ([
            SELECT Name, Id, CEP__c, City__c, State__c
            FROM Freight__c
            WHERE (CEP__c IN :accountSetIdsCep OR CEP__c = null) AND
            (City__c IN :accountSetIdCity OR City__c = null) AND
            (State__c IN :DistributionCenterSetStateId OR State__c = null)
        ]); 

        System.debug(freightMap);
        
        for (Freight__c freight : freightMap.values()) {
            if(accountSetIdsCep.contains(freight.CEP__c) && freight.CEP__c != null) {
                System.debug('contain: '+ freight.Name + ' ' + freight.CEP__c);
                freightSetInOrder = freight.Id;
                break;
            }
            else if (accountSetIdCity.contains(freight.City__c) && freight.City__c != null) {
                System.debug('contain: '+ freight.Name + ' ' + freight.City__c);
                freightSetInOrder = freight.Id;
                break;
            }
            else if (DistributionCenterSetStateId.contains(freight.State__c) && freight.State__c != null) {
                System.debug('contain: '+ freight.Name + ' ' + freight.State__c);
                freightSetInOrder = freight.Id;
                break;
            }
        }

        for (Order order : orderList) {
            order.Freight__c = freightSetInOrder;
        }
    }
}