public with sharing class OrderHelper {
    public OrderHelper() {}

    public static void totalFreight(List<Order> orderList) {

        Map<Id, Freight__c> freightMap = new map <Id, Freight__c> ([
            SELECT Id, FreightByWeight__c, FreightByVolume__c, FreightBase__c, CEP__c, Name, City__c, State__c
            FROM Freight__c
        ]);

        Map<Id, OrderItem> orderItemMap = new map <Id, OrderItem> ([
            SELECT Id, Quantity,Volume__c,Weight__c, OrderId
            FROM OrderItem
        ]);

        for(Order order: orderList) {            
            for(Freight__c freight : freightMap.values()) {
                System.debug('function');
                order.Freight__c = cepComparation(freight.CEP__c, freight.City__c, freight.Id, 
                    order.Freight__c, freight.State__c, order.DistributionCenter__c);
            }
        }        
    }

    public static Id cepComparation(String Cep, String City, String freightId, 
        String Freight, String freightState, String orderDistributionCenter) {

        Map<Id, Account> accountMap = new Map<Id, Account>([
            SELECT City__c, CEP__c, Code__c
            FROM Account
        ]);
        
        Map <Id, DistributionCenter__c> distCenterMap = new Map<Id, DistributionCenter__c> ([
            SELECT State__c
            FROM DistributionCenter__c
        ]);

        for(Account account : accountMap.values()) {
            for(DistributionCenter__c distributionCenter : distCenterMap.values()){
                if(account.CEP__c != null && CEP == account.CEP__c) {
                    System.debug('CEP' + ' ' +freightId);
                    return freightId;
                } 
                else if(account.City__c != null && account.City__c == City) {
                    System.debug('CEP' + ' ' +freightId);
                    return freightId;
                } 
                else if(!String.isBlank(orderDistributionCenter)) {
                    if(distributionCenter.State__c != null && distributionCenter.State__c == freightState) {
                        System.debug('State' + ' ' +freightId);
                        return freightId;
                    }
                }
                
            }
        } 
        System.debug('ultimo return');
        return Freight;
    }
}