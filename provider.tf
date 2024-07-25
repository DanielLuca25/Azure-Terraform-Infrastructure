terraform{
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = ">=3.0"
      }
    }

    # backend "azurerm"{
    #     subscription_id = "76ee20cb-86ed-48e1-a2a8-abc9d6ed9969"
    #     resource_group_name = "rg-terraform"
    #     storage_account_name = "terraformstgacc25"
    #     container_name = "terraformstgcont"
    #     key = "terraform.tfstate"
    # }

}


provider "azurerm"{
    features {
      
    }
}