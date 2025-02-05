###############################################################################
## Load Balance Classic

resource "aws_elb" "lb_classic" {
    name            = "elb-${var.name}"
    subnets         = var.subnets
    security_groups = var.security_groups
    internal        = var.internal

    cross_zone_load_balancing   = var.cross_zone_load_balancing
    idle_timeout                = var.idle_timeout
    connection_draining         = var.connection_draining
    connection_draining_timeout = var.connection_draining_timeout

    dynamic "listener" {
        for_each    = var.listener
        content {
            instance_port       = listener.value.instance_port
            instance_protocol   = listener.value.instance_protocol
            lb_port             = listener.value.lb_port
            lb_protocol         = listener.value.lb_protocol
            ssl_certificate_id  = lookup(listener.value, "ssl_certificate_id", null)
        }
    } 

    dynamic "access_logs" {
        for_each    = length(keys(var.access_logs)) == 0 ? [] : [var.access_logs]
        content {
            bucket        = access_logs.value.bucket
            bucket_prefix = lookup(access_logs.value, "bucket_prefix", null)
            interval      = lookup(access_logs.value, "interval", null)
            enabled       = lookup(access_logs.value, "enabled", true)
        }
    }

    health_check {
        healthy_threshold   = lookup(var.health_check, "healthy_threshold")
        unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
        timeout             = lookup(var.health_check, "timeout")
        target              = lookup(var.health_check, "target")
        interval            = lookup(var.health_check, "interval")
    }

    tags = merge(
        {
            "Name"    = var.name
        },
        var.default_tags,
    )
}
