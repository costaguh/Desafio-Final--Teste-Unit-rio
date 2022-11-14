public with sharing class OrderItemHelper {   
    public OrderItemHelper() {}

    public static void calcFreight(List<orderItem> orderItemList) {
        Decimal orderTotalVolume;
        Decimal orderTotalWeight;
        Decimal orderTotalQuantity;

        Map<Id, OrderItem> orderItemMap = new map <Id, OrderItem> ([
        SELECT Quantity,Volume__c,Weight__c 
        FROM OrderItem
        ]);

        for(OrderItem orderItem : orderItemList) {
            orderTotalVolume = orderItem.Volume__c;
            orderTotalWeight = orderItem.Weight__c;
            orderTotalQuantity = orderItem.Quantity;
    
            orderItem.Description = 'teste';
            System.debug(orderTotalVolume);
        }
        
        System.debug('oi');
    }
}
