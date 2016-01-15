#!/bin/sh
files="test/Networking/*.m"
for i in $files
do
    sed '/^    $/d;/^$/{N;/^\n$/d;}' $i > $i.out
    mv $i.out $i
done

sed -e 's/NSString/String/' -e 's/NSNumber/Integer 32/' -e 's/NSArray/Transformable/' test/Models/CoreData.xcdatamodel/contents > out
mv out test/Models/CoreData.xcdatamodel/contents
