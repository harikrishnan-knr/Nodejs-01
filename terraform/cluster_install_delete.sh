#!/bin/bash

echo "----------------------------------------"
echo "EKS Cluster Creating and Deleting Script"
echo "----------------------------------------"

echo "Select The Method [1] Create [2] Delete : "
read num

if [ "$num" -eq 1 ] 2>/dev/null; then
    echo "Enter Cluster Name :"
    read cluster_name

    echo "Enter Region :"
    read region

    valid_selection=false

    while [ "$valid_selection" = false ]; do
        echo "Node Machine Type:"
        echo "[0] Default - t3.small"
        echo "[1] t3.micro"
        echo "[2] t3.small"
        echo "[3] c7i-flex.large"
        echo "[4] m7i-flex.large"

        read type_num

        case "$type_num" in
            0|2)
                type="t3.small"
                valid_selection=true
                ;;
            1)
                type="t3.micro"
                valid_selection=true
                ;;
            3)
                type="c7i-flex.large"
                valid_selection=true
                ;;
            4)
                type="m7i-flex.large"
                valid_selection=true
                ;;
            *)
                echo "-----------------------------------------------------"
                echo "You Entered an Invalid Option!! Please try again."
                echo "-----------------------------------------------------"
                ;;
        esac
    done

    echo "---------- Cluster Creating ----------"
    echo "Cluster Name : $cluster_name"
    echo "Region       : $region"
    echo "Node Type    : $type"

    eksctl create cluster \
      --name "$cluster_name" \
      --region "$region" \
      --node-type "$type"

    echo "---------- Cluster Creation Completed !!! ----------"

elif [ "$num" -eq 2 ] 2>/dev/null; then
    echo "Enter Cluster Name :"
    read cluster_name

    echo "Enter Region :"
    read region

    echo "---------- Cluster Deleting ----------"
    echo "Cluster Name : $cluster_name"
    echo "Region       : $region"

    eksctl delete cluster \
      --name "$cluster_name" \
      --region "$region"

    echo "---------- Cluster Deletion Completed !!! ----------"

else
    echo "Invalid option. Please choose [1] to Create or [2] to Delete."
fi
