# create load balancer

***step 1*** create 2 instance with different AZ and different server (HTTP enabled)
***ster 2*** create a target group (avalable at left dashbort of EC2 resource)
***step 3*** inside targeyt group select both instance and "include as pending below" ( click on create target group)
***step 4*** create load balancer 
***step 5*** create a custem security group with "HTTP enabled" in inbound rule and outbound rule must contend" all trafic enabled"
***step 6*** select target group which is created privesly (click on creat load balancer)
***step 7*** hit DNS which is avalable in load balancer 
***step 8*** go to load balancer and select loadbalancer now click on resource map and check entire path