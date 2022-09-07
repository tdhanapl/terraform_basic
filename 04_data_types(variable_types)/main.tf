output "output_string_type" {
    value = var.string_type_var
}


output "output_number_type_var" {
    value = var.number_type_var
}

output "output_number_type_ex_02_var" {
    value = var.number_type_ex_02_var
}

output "output_boolean_type_var" {
    value = var.boolean_type_var
}

output "output_list_type_var" {
    value = var.list_type_var
}
#[for element in var.list_type_var : element]
#output_2nc_index_of_list
output "output_2nc_index_of_list" {
    value = var.list_type_var[1]
}

output "output_list_any_type_var" {
    value = var.list_any_type_var
}
output "output_map_type_var" {
    value = var.map_type_var
}
output "output_enviroment_key_from_map_type_var" {
    value = var.map_type_var["enviroment"]
}

output "output_type_any_example_02_var" {
    value = var.any_type_example_02_var
}

output "specific_key_from_any_type_example_02_var" {
    value = var.any_type_example_02_var.total_resource_count
}

output "output_obejct" {
    value = var.object_type_var
}