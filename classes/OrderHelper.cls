public with sharing class OrderHelper {
    public OrderHelper() {}

    public static void totalFreight(List<Order> orderList) {

        Set<Id> orderIdSet = new Set<Id>();

        Map<Id, Order> freighOrdertMap = new map <Id, Order>([
            SELECT Id, Freight__c, TotalFreight__c, Description, Pricebook2Id
            FROM Order
        ]);        

        Map<Id, Freight__c> freightMap = new map <Id, Freight__c> ([
            SELECT Id, FreightByWeight__c, FreightByVolume__c, FreightBase__c, CEP__c, Name
            FROM Freight__c
        ]);

        Map<Id, OrderItem> orderItemMap = new map <Id, OrderItem> ([
            SELECT Id, Quantity,Volume__c,Weight__c, OrderId
            FROM OrderItem
        ]);

        Decimal countOrderItem;
        Decimal countFreight;

        for(Order order: orderList) {            
            for(Freight__c freight : freightMap.values()) {
                for(OrderItem orderItem : orderItemMap.values()) {
                    if(order.id == orderItem.OrderId){
                        System.debug(order.id + ' ' + orderItem.OrderId);
                        if(order.Freight__c == freight.Id){
                            System.debug(freight.FreightByWeight__c + ' ' + orderItem.Weight__c); 
                            freight.FreightByWeight__c += freight.FreightByWeight__c;                           
                            order.totalFreight__c = orderItem.Weight__c * freight.FreightByWeight__c ;
                        }  
                    }
                }
                
                cepComparation(freight.CEP__c, freight.Name, order.Freight__c);
            }
        }
    }

    public static void cepComparation(String Cep, String Name, String Freight) {
        Map<Id, Account> accountMap = new Map<Id, Account>([
            SELECT City__c, CEP__c, Code__c
            FROM Account
        ]);

        for(Account account : accountMap.values()) {
            if(account.CEP__c != null && CEP == account.CEP__c) {                
                Freight = Name;
            }
        }
    }
}