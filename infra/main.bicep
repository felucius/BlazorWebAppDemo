// --- PARAMETERS ---
@description('De naam van de Web App')
param webAppName string

@description('De Azure regio')
param location string = resourceGroup().location

@description('De volledige image naam die vanuit de pipeline wordt meegestuurd')
param containerImage string = '://mcr.microsoft.com'

// --- VARIABELEN ---
var appServicePlanName = 'asp-${webAppName}'
var acrName = 'acr${uniqueString(resourceGroup().id)}' // Genereert een unieke naam voor je Registry

// --- 1. RESOURCE: App Service (Klassiek) ---
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'app'
  properties: {
    reserved: true // Veranderd naar true voor Linux support (Blazor .NET 10)
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|10.0'
      alwaysOn: false
      ftpsState: 'FtpsOnly'
    }
  }
}

// --- 2. RESOURCE: Container Registry (ACR) ---
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

// --- 3. RESOURCE: Container Apps Omgeving (Logs + Environment) ---
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'log-${webAppName}'
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
  }
}

resource env 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: 'env-${webAppName}'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

// --- 4. RESOURCE: Azure Container App (ACA) ---
resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: '${webAppName}-aca'
  location: location
  properties: {
    managedEnvironmentId: env.id
    configuration: {
      ingress: {
        external: true
        targetPort: 8080 // Blazor .NET 10 luistert standaard op 8080
        allowInsecure: false
      }
      registries: [
        {
          server: '${acr.name}.azurecr.io'
          username: acr.listCredentials().username
          passwordSecretRef: 'acr-password'
        }
      ]
      secrets: [
        {
          name: 'acr-password'
          value: acr.listCredentials().passwords[0].value
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'blazor-app'
          image: containerImage
          resources: {
            cpu: json('0.25')
            memory: '0.5Gi'
          }
        }
      ]
      scale: {
        minReplicas: 0 // Kosteloos bij geen gebruik
        maxReplicas: 1
      }
    }
  }
}

// --- OUTPUTS ---
output webAppUrl string = webApp.properties.defaultHostName
output containerAppUrl string = containerApp.properties.configuration.ingress.fqdn
output acrLoginServer string = acr.properties.loginServer
