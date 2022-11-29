@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param prefix string = 'sto.'
param storageName string = 'storage'
param currlocation string = resourceGroup().location
param globalRedundancy bool
param containerName string = 'container2'

resource storageExample 'Microsoft.Storage/storageAccounts@2022-05-01' ={
  name: '${prefix}${uniqueString(storageName)}'
  sku:{
    name : globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
    
  }
  kind: 'StorageV2' 
  location: currlocation
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' = {
  name: '${storageExample.name}/default/${containerName}'
}

output output_id string = storageExample.id
output output_name string = storageExample.name
output sto_blob string = storageExample.properties.primaryEndpoints.blob
