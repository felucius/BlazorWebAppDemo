// 1. PARAMETERS
@description('De naam van de Web App (moet globaal uniek zijn in Azure)')
param webAppName string

@description('De Azure regio waar de resources worden geplaatst')
param location string = resourceGroup().location

// 2. VARIABELEN
var appServicePlanName = 'asp-${webAppName}'

// 3. RESOURCE: App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'           // Gratis tier voor testen (Free)
    tier: 'Free'
  }
  kind: 'app'
  properties: {
    reserved: false      // Stel dit in op 'true' als je Linux gebruikt, 'false' voor Windows
  }
}

// 4. RESOURCE: Web App (De Blazor applicatie zelf)
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true      // Forceer HTTPS (best practice)
    siteConfig: {
      netFrameworkVersion: 'v10.0' // Specifiek voor .NET 10 (Blazor)
      alwaysOn: false             // Moet 'false' zijn op de Free tier
      ftpsState: 'FtpsOnly'
    }
  }
}

// 5. OUTPUTS (Handig om na de deploy de URL te zien in je pipeline logs)
output websiteUrl string = webApp.properties.defaultHostName
