public with sharing class OrderHelper {
    public OrderHelper() {}

    public static void calcFreight(List<Order> orderList) {
        Set<String> orderIds = new Set<String>();
        Set<String> accountIds = new Set<String>();

        for (Order order : orderList) {
            accountIds.add(order.AccountId);
            orderIds.add(order.Id);
        }

        System.debug('orderIds: ' +orderIds);
        System.debug('accountIds: ' +accountIds);

        Map<Id, Account> accountMap = new Map<Id, Account> ([
            SELECT Id, CEP__c, City__c
            FROM Account
            WHERE Id = :accountIds
        ]);       

        Set<String> postalCodes = new Set<String>();
        Set<String> cityIds = new Set<String>();
        Set<String> stateIds = new Set<String>();
        
        for (Account account : accountMap.values()) {
            System.debug(accountMap);
            postalCodes.add(account.CEP__c);
            cityIds.add(account.City__c);
        }

        Map<Id, Freight__c> freightMap = new Map<Id, Freight__c> ([
            SELECT  Id, Name, CEP__c, City__c, State__c, DistributionCenter__c,
                    FreightByVolume__c, FreightByWeight__c, FreightBase__c
            FROM Freight__c
            WHERE CEP__c IN :postalCodes
            OR City__c IN :cityIds
        ]);

        Set<String> freightCityIds = new Set<String>();
        Set<String> freightIds = new Set<String>();
        String freightSetValue;
        String distributionCenterSetValue;    
        Map<Id, DistributionCenter__c> distributionCenterMap = new Map<Id, DistributionCenter__c> ([
            SELECT Id, State__c
            FROM DistributionCenter__c
        ]);

        Set<String> distribuitionCenterStatesId  = new Set<String>();        
        
        for (DistributionCenter__c distributionCenter : distributionCenterMap.values()) {
            distribuitionCenterStatesId.add(distributionCenter.State__c);
            System.debug(distribuitionCenterStatesId); 
        }
        
        System.debug('oi');
        for (Freight__c freight : freightMap.values()) {
            System.debug(distribuitionCenterStatesId + ' ' + freight.State__c);
            if (postalCodes.contains(freight.CEP__c)) {
                freightSetValue = freight.id;
                System.debug(freight.Name + ' '+ freight.CEP__c);
            }

            else if (cityIds.contains(freight.City__c)) {
                freightSetValue = freight.id;
                System.debug(freight.Name + ' '+ cityIds);
            }
            else if (distribuitionCenterStatesId.contains(freight.State__c)) {
                freightSetValue = freight.id;
                System.debug(freight.Name + ' '+ freight.State__c);
            }
        }

        for (Order order : orderList) {
            order.Freight__c = freightSetValue;
            System.debug(order.Freight__c);
        }
    }
}