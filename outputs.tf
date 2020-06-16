output "lb_classic_id" {
    value   = "${aws_elb.lb_classic.id}" 
}
output "dns_name" {
    value   = aws_elb.lb.dns_name
    
}