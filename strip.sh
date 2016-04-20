#!/bin/sh
files="../../FMCG/Networking/*.m"
for i in $files
do
    sed '/^    $/d;/^$/{N;/^\n$/d;}' $i > $i.out
    sed 's/* requestDescriptor/ requestDescriptor/' $i.out > $i
    rm $i.out
done

sed -e 's/NSString/String/' -e 's/NSNumber/Integer 32/' -e 's/NSArray/Transformable/' -e 's/id"/id" indexed="YES"/' -e 's/Id"/Id" indexed="YES"/' -e 's/title"/title" indexed="YES"/' ../../FMCG/Models/CoreData.xcdatamodel/contents > out
mv out ../../FMCG/Models/CoreData.xcdatamodel/contents
