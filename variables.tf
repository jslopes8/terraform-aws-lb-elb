variable "name" {
    type    = string
}
variable "subnets" {
    type    = list(string)
    default = []
}
variable "security_groups" {
    type    = list(string)
    defaul  = []
}
variable "listener" {
    type    = list(map(string))
}
variable "health_check" {
    type    = map(string)
}
variable "access_logs" {
  type        = map(string)
  default     = {}
}
variable "default_tags" {
    type    = map(string)
    default = {}
}
variable "cross_zone_load_balancing" {
    type    = bool
    default = true
}
variable "idle_timeout" {
    type    = number
}
variable "connection_draining" {
    type    = bool
    default = true
}
variable "connection_draining_timeout" {
    type    = number
}
