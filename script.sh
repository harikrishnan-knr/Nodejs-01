#!/bin/bash

    valid_selection=false

    while [ "$valid_selection" = false ]; do
        echo "What you want to do ?:"
        echo "[0] Default EKS + Docker Install"
        echo "[1] Docker Install"
        echo "[2] EKS + Docker Install"
        echo "[3] Cluster Create"
        echo "[4] Cluster Delete"
        
read method

        case "$method" in
            0|2)
            # Username of Linux
            echo "Enter Your Username :"
            read USERNAME
            echo "Username : " $USERNAME

            # Update & Upgrade
            echo "system update & plugin installation"

            sudo apt update
            sudo apt install unzip wget curl -y

            echo "system update & plugin installation completed!!!"

            # Install Docker
            echo "docker installing"

            curl -fsSL https://get.docker.com -o get-docker.sh
            sudo sh ./get-docker.sh

            echo "docker installation completed!!!"

            # Service start & enable
            echo "docker service going to start"

            sudo systemctl start docker
            sudo systemctl enable docker

            echo "docker service enable and stated!!!"

            # User add in Docker group
            echo "user adding in docker group"

            sudo usermod -aG docker $USERNAME

            echo "user added in docker group"

            # Install awsclient
            echo "awsclient installing"

            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
            unzip awscliv2.zip
            sudo ./aws/install

            echo "awsclient installation completed!!!"

            # Install EKS kubectl
            sudo apt-get update
            sudo apt-get install -y apt-transport-https ca-certificates curl
            curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
            echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
            sudo apt-get update
            sudo apt-get install -y kubectl

            echo "EKS kubectl installation completed!!!"

            # EKS version 
            echo "checking the kubectl installed or not"
            kubectl version

            # for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
            ARCH=amd64
            PLATFORM=$(uname -s)_$ARCH

            curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

            # (Optional) Verify checksum
            curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

            tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

            sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl

            echo "Script completed !!!!"
                valid_selection=true
                ;;
            1)
                echo "Enter Your Username :"
                read USERNAME
                echo "Username : " $USERNAME

                # Update & Upgrade
                echo "system update & plugin installation"

                sudo apt update
                sudo apt install unzip wget curl -y

                echo "system update & plugin installation completed!!!"

                # Install Docker
                echo "docker installing"

                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh ./get-docker.sh

                echo "docker installation completed!!!"

                # Service start & enable
                echo "docker service going to start"

                sudo systemctl start docker
                sudo systemctl enable docker

                echo "docker service enable and stated!!!"

                # User add in Docker group
                echo "user adding in docker group"

                sudo usermod -aG docker $USERNAME

                echo "user added in docker group"

                valid_selection=true
                ;;
            3)
                echo "----------------------------------------"
                echo "EKS Cluster Creating Script"
                echo "----------------------------------------"

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
                    valid_selection=true
                    ;;
            4)
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

                valid_selection=true
                ;;

            *)
                echo "-----------------------------------------------------"
                echo "You Entered an Invalid Option!! Please try again."
                echo "-----------------------------------------------------"
                ;;
        esac
    done
