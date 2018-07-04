# Deployment

```
az login
az group create -n myNBResourceGroup -l uksouth
az ad sp create-for-rbac --query [appId,password,tenant]
```
- Output represents: ```client_id```, ```client_secret``` and ```tenant_id```.
	- Insert these into ```creds.json``` file.

```
az account show --query [id] --output tsv
```
- Output is the ```subscription_id``` to insert into ```creds.json``` file.

```
az storage account create -n mynbstorageaccount -g myNBResourceGroup -l uksouth --sku Premium_LRS
```
```
packer build -var-file=creds.json jupyter-sirf.json
```
```shell
export IMG=<VMDISKIMAGE>
```
where ```VMDISKIMAGE``` is the image name given during a successful Packer build.

- To create a VM from the image:
```
az vm create -g $RESGROUP -n $MACHNAME --image $IMG --admin-username sirfuser --generate-ssh-keys --public-ip-address-dns-name $MACHNAME --size $MACHSIZE
```

- Open up port 9999 for Jupyter traffic:
```
az vm open-port --resource-group $RESGROUP --name $MACHNAME --port 9999
```

- The previous two steps are automated in `spinUp.sh`.

- List IPs
```
az vm list-ip-addresses --output table
```

- Cleaning up (and not incurring costs)
```
az vm delete -g myNBResourceGroup -n myFirstVM --yes #Remove VM
az vm delete --ids $(az vm list -g MyResourceGroup --query "[].id" -o tsv) #Remove all VMs
az group delete -n myNBResourceGroup #Delete everything in the resource group
```
