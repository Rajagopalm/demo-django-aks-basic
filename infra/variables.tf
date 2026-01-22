variable "subscription_id" {
	type = string
}

variable "location" {
	type    = string
	default = "eastus"
}

variable "rg_name" {
	type = string
}

variable "aks_name" {
	type = string
}

variable "acr_name" {
	type = string
}

variable "dns_zone" {
	type    = string
	default = ""
} # optional

variable "node_count" {
	type    = number
	default = 2
}

variable "node_size" {
	type    = string
	default = "standard_dc2ds_v3"
}
