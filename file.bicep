
@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param storageName string
param currlocation string = resourceGroup().location


resource storageExample 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: uniqueString(storageName)
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  location: currlocation
}

output storageName string = storageExample.id

uniqueString() and resourceGroup() <--use these
resourceGroup().location
