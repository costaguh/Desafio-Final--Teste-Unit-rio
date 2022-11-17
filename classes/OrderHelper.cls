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

        for(Order order: orderList) {            
            for(Freight__c freight : freightMap.values()) {
                for(OrderItem orderItem : orderItemMap.values()) {
                    if(order.id == orderItem.OrderId){
                        if(order.Freight__c == freight.Id){
                            cepComparation(freight.CEP__c, freight.City__c, freight.Name, 
                            order.Freight__c, freight.State__c, order.DistributionCenter__c);

                            orderQuantityAccumulator += orderItem.Quantity;
                            freightBaseAccumulator = orderQuantityAccumulator * freight.FreightBase__c;

                            orderWeightAccumulator += orderItem.Weight__c;
                            freightByWeightAccumulator = orderWeightAccumulator * freight.FreightByWeight__c;
                            System.debug(freightByWeightAccumulator);
                            
                            orderVolumeAccumulator += orderItem.Volume__c;
                            freightByVolumeAccumulator = freight.FreightByVolume__c;

                            if(freightBaseAccumulator >= freightByWeightAccumulator && freightBaseAccumulator >= freightByVolumeAccumulator) {
                                System.debug(freightBaseAccumulator);
                            }                            
                            
                            else if(freightByWeightAccumulator >= freightBaseAccumulator && freightByWeightAccumulator >= freightByVolumeAccumulator) {
                                System.debug(freightByWeightAccumulator);
                            } 
                            
                            else {
                                System.debug(freightByVolumeAccumulator);
                            }
                        }
                    }
                }           
            }
        }        
    }

    public static void cepComparation(String Cep, String City, String freightName, 
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
                    Freight = freightName;
                } 
                else if(account.City__c != null && account.City__c == City) {
                    Freight = freightName;
                } 
                else if(!String.isBlank(orderDistributionCenter)) {
                    System.debug('State' + ' ' +DistributionCenter.State__c);
                    if(distributionCenter.State__c != null && distributionCenter.State__c == freightState) {
                        Freight = freightName;
                    }
                }
            }
        }
    }
}