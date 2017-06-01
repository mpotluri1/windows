output "Suntrust DNS Address" {
  value = "${aws_instance.suntrust_windows_stack.public_dns}"
}

output "Suntrust Ip address" {
  value = "${aws_instance.suntrust_windows_stack.public_ip}"
}