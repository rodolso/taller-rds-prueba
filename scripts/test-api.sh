#!/bin/bash

API="http://<EC2_IP>:5000"

echo "========================================"
echo " Test de la API - Advertising Model"
echo "========================================"
echo ""

call() {
    local tv=$1
    local radio=$2
    local newspaper=$3
    echo "-> Prediccion tv=$tv radio=$radio newspaper=$newspaper"
    curl -s "$API/api/v1/predict?tv=$tv&radio=$radio&newspaper=$newspaper"
    echo ""
}

call 230.1 37.8 69.2
sleep 2

call 44.5 39.3 45.1
sleep 2

call 17.2 45.9 69.3
sleep 2

call 151.5 41.3 58.5
sleep 2

call 180.8 10.8 58.4
sleep 2

call 8.7 48.9 75.0
sleep 2

call 57.5 32.8 23.5
sleep 2

call 120.2 19.6 11.6
sleep 2

call 199.8 2.6 21.2
sleep 2

# Una llamada con valor faltante para ver el warning
echo "-> Prediccion con newspaper faltante (missing value)"
curl -s "$API/api/v1/predict?tv=66.1&radio=5.8"
echo ""
sleep 2

echo ""
echo "========================================"
echo " Verificando registros guardados en RDS"
echo "========================================"
echo ""
curl -s "$API/api/v1/predictions?limit=10" | python3 -m json.tool
