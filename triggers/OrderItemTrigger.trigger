trigger OrderItemTrigger on OrderItem (before insert, after insert, before update) {

    System.debug(Trigger.new);

    Decimal freightByVolume;
    Decimal freightByWeight;
    Decimal freightBase;

    Map<Id, Freight__c> freightMap = new map <Id, Freight__c>([
        SELECT FreightByWeight__c, FreightByVolume__c, FreightBase__c
        FROM Freight__c
    ]);

    for(Freight__c freight : freightMap.values()) {
        freightByVolume = freight.FreightByVolume__c;
        freightByWeight = freight.FreightByWeight__c;
        freightBase = freight.FreightBase__c;

        if(freightByVolume == null) {
            System.debug('null value');
        }
    }

    System.debug('order item trigger');
    OrderItemTriggerHandler handler = new OrderItemTriggerHandler(
        Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap
    );
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            handler.beforeInsert();
        }
    }
}