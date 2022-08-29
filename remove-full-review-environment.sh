#!/bin/bash

for NAMESPACE in $(kubectl get po --all-namespaces | egrep -i "review" | cut -d " " -f1 | uniq);
do
	
        echo "Namespace Project: $NAMESPACE" >> remove-review.log;
        echo "Deploy Name:" >> remove-review.log
        for DEPLOY_NAME in $(kubectl get deploy -n $NAMESPACE | cut -d " " -f1 | egrep -i "review");
	do 
   		kubectl delete deploy "$DEPLOY_NAME" -n "$NAMESPACE" --force --grace-period=0 >> remove-review.log;
 	done
 
        echo "Service Name:" >> remove-review.log; 
	for SERVICE_NAME in $(kubectl get svc -n $NAMESPACE | cut -d " " -f1 | egrep -i "review"); 
 	do
 		kubectl delete svc "$SERVICE_NAME" -n "$NAMESPACE" --force --grace-period=0 >> remove-review.log;
	done
	
	echo "Ingress Name:" >> remove-review.log;
	for INGRESS_NAME in $(kubectl get ingress -n $NAMESPACE | cut -d " " -f1 | egrep -i "review");
	do
		kubectl delete ingress "$INGRESS_NAME" -n "$NAMESPACE" --force --grace-period=0 >> remove-review.log;	
	done	
	
	echo "#########################################################################" >> remove-review.log       

done




