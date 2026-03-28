#!/bin/bash

REGIONS=("eastus" "westus2" "centralus")
SIZES=("Standard_D2s_v3" "Standard_D2_v3" "Standard_A2_v2")

for region in "${REGIONS[@]}"
do
  for size in "${SIZES[@]}"
  do
    echo "Trying $region with $size"
    terraform apply -auto-approve \
      -var="location=$region" \
      -var="vm_size=$size" && exit 0
  done
done

echo "All failed ❌"