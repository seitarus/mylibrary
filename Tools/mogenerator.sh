#/bin/bash

SCRIPT_PATH="`dirname \"$0\"`"
cd $SCRIPT_PATH

echo ""

echo "Generando clases"
cd ../BookList/Models

mogenerator --swift --model Library.xcdatamodeld/Library.xcdatamodel --machine-dir=Machine --human-dir=Entities

echo "Clases generadas"

echo ""
