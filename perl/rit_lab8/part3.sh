#!/bin/sh
TAX_RATE=0.08
TOTAL=0
COUNT=0
PRICE=x

while [ "$PRICE" != "q" ]; do
    echo -n "Item Price: "
    read PRICE JUNK
    if [ "$PRICE" != "q" ]; then
        TOTAL=`expr $TOTAL + $PRICE`
        COUNT=`expr $COUNT + 1`
    fi
done

if [ $COUNT -eq 0 ]; then
    exit
fi

AVERAGE=`expr $TOTAL / $COUNT`
TAX=`echo $TOTAL '*' $TAX_RATE | bc`
echo "Average: $AVERAGE"
echo "Subtotal: $TOTAL"
echo "Tax: $TAX"
echo "TOTAL: "`echo "$TOTAL" + "$TAX" | bc`
