variable "string_type_var" {
    type = string
    description = "example of a string type variable"
    default = "value"
}

variable "number_type_var" {
    type = number
    description = "example of a number type variable"
    default = 10.99
}

variable "number_type_ex_02_var" {
    type = number
    description = "another example of a number type variable"
    default = "100"
}


variable "boolean_type_var" {
    type = bool
    description = "example of a bool type variable"
    default = true // "true"
}


variable "list_type_var" {
    type = list(string)
    description = "example of a list of string type variable"
    default = [ "apple", "banana", "jack fruit", "mango", "grapes" ]
}

variable "list_any_type_var" {
    type = list(any)
    description = "example of a list of any type variable"
    //default = [] 
    # or it can be used as 
    default = [ {key = "value"}, {key1=  "value1"}]
}

variable "map_type_var" {
    type = map
    description = "example of a map type variable"
    # resource tagging
    default = {
        enviroment  = "dev"
        cost_centre = 111034
        bool_type = true
        project     = "learning azure"
    }
}

variable "any_type_example_02_var" {
    type = any
    description = "another example of a complex map type variable"
    # a map represents the key value pair
    default = {
        env = "dev"
        resource_created = false
        total_resource_count = 25
        resources_by_category  = {
                                    network = ["vnet" , "firewall", "nsg"]
                                    app_service = "web app"
                                    security = ["keyvault" ]
                                    monitoring = {
                                                    logs           = ["log analytics","storage"]
                                                    metrics        = "log analytics"
                                                    retention_days = 90
                                                    policy_enabled = false
                                                 }
                                    
                                 }
    }
}

variable "object_type_var" {
    description = "(optional) describe your variable"
    type = object({
         first_name  = string
         last_name   = string
         age = number
    })
    default = {
      age = 1
      first_name = "john"
      last_name = "smith"
    }
}