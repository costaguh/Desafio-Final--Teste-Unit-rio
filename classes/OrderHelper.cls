public with sharing class OrderHelper {
    public OrderHelper() {}

    public static void totalFreight(List<Order> orderList) {
        Decimal orderQuantityAccumulator = 0;
        Decimal orderWeightAccumulator = 0;
        Decimal orderVolumeAccumulator = 0;

        Decimal freightBaseAccumulator = 0;
        Decimal freightByWeightAccumulator = 0;
        Decimal freightByVolumeAccumulator = 0;

        Map<Id, Freight__c> freightMap = new map <Id, Freight__c> ([
            SELECT Id, FreightByWeight__c, FreightByVolume__c, FreightBase__c, CEP__c, Name, City__c, State__c
            FROM Freight__c
        ]);

        Map<Id, OrderItem> orderItemMap = new map <Id, OrderItem> ([
            SELECT Id, Quantity,Volume__c,Weight__c, OrderId
            FROM OrderItem
        ]);
        
        for(Order order : orderList) {            
            for(Freight__c freight : freightMap.values()) {
                order.Freight__c = cepComparation(freight.CEP__c, freight.City__c, freight.Id, 
                order.Freight__c, freight.State__c, order.DistributionCenter__c);

                for(OrderItem orderItem : orderItemMap.values()) {
                    if(order.Freight__c == freight.Id){                       

                        orderQuantityAccumulator += orderItem.Quantity;
                        freightBaseAccumulator = orderQuantityAccumulator * freight.FreightBase__c;

                        orderWeightAccumulator += orderItem.Weight__c;
                        freightByWeightAccumulator = orderWeightAccumulator * freight.FreightByWeight__c;
                    
                        orderVolumeAccumulator += orderItem.Volume__c;
                        freightByVolumeAccumulator = freight.FreightByVolume__c;

                        if(freightBaseAccumulator >= freightByWeightAccumulator && freightBaseAccumulator >= freightByVolumeAccumulator) {
                            order.totalFreight__c = freightBaseAccumulator;
                        }                            
                    
                        else if(freightByWeightAccumulator >= freightBaseAccumulator && freightByWeightAccumulator >= freightByVolumeAccumulator) {
                            order.totalFreight__c = freightByWeightAccumulator;
                        } 
                    
                        else {
                            order.totalFreight__c = freightByVolumeAccumulator;
                        }
                    }    
                }
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
                    return freightId;
                } 
                else if(account.City__c != null && account.City__c == City) {
                    return freightId;
                } 
                else if(!String.isBlank(orderDistributionCenter)) {
                    if(distributionCenter.State__c != null && distributionCenter.State__c == freightState) {
                        return freightId;
                    }
                }
                
            }
        } 
        return Freight;
    }
}