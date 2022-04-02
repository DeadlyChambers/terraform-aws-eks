# Growth Driven Development

**TLDR;** Aws, K8s, and TF can be described in the same way as we understand DNA. Which is constantly
in a state of growth. Each Helix Aws and K8s are both dependent, and indepent of each other. TF is 
instrumental in coordinating the bond between the two while they are simultanously growing.

There are still a lot of things I don't know, and problems I haven't begun to know exist. But it
is sort of a cool way to conecptualize their interdepency. The analogy also feels like it is
spot on, for various different levels. This might be sort of a rant, but it is also an initial theory.
There are a bunch of problems I haven't seen yet, and there are many pieces to the puzzle I don't fully
understand. So this theory may morph a bit. This started with trying to understand how I can use TF to
create the CNI-IRSA while trying to also create the Infrastructure to complete the connection.

 I want to tie multiple resource roles into the creation of the Identity Provider,
 and it's subsequent set of policies. What I am thinking is TF can create the Iam user for Id Provider (k8s)
 while creating the policies that can be used by roles in AWS that will tie to k8s Services/Contexts/Namespaces and
 AWS Roles/LaunchTemplates. While neither has physical resources to back them up. Just relationships, or contracts 
 are in place, the next step is creating resources in a proper order across AWS and K8s. What I am noodling on, 
 is to trying to find the proper balance between, using resource roles (which don't need an actual resource)
, service roles (which can could or could not require existance of resources), and how
 kubernetes Clusters, Contexts, and NameSpaces are created and managed in relation to their own services'/users and with subsequent Deployments, Services, and Pods.

 A Kubernetes Cluster can span multiple subnets, ec2 instances, target groups, roles, (vpcs)?
 The important piece of the cluster, is the Control Plane (obviously other things as well), for which there is 
 only 1 control plane. Meaning the Cluster and the VPC are really good relational starting points.
 I feel like that is solid ground to stand on. I will try to speak in terms of VPC and Cluster as 
 sort of the chicken, and the egg for the following decisions, and future considerations. They
 will also be the root of two main abstractions in similar terminology. Which the terminology is, K8s and AWS 
 are the helixes, and  Terraform is more of the connection between the Helixes. The interesting thing about K8s, TF, and Aws is the order in which things can happen, and even how they can hhappen are a constantly variable.
 However, that variance, depending on where we are in the Infrastructure Lifecyle does have a limit.
 Creating a new EC2 via purely TF does or does not require the Creation of a VPC in the same cycle, however, EC2 creation 100% requires the existance of a VPC, meaning EC2 Creation w/Stability is 1 directionalal in relation to a VPC. Now, if we flip that specific scenario backwards. I can create a Launch Template, that defines an
 EC2 in such a way that I could continue with the next atomic operation without having to know
 something else definitive. I can create a Launch Template, that would have an Instance Profile
 attached to it, which allows me to build in a connection with the other Helix (K8s). Terraform can create
 an Instance Profile, that would describe the AMI, the Policies for the instance the subnet, and from that
 Role, and Launch Temlate Id, I can make a definitive connection to k8s in the same atomic process with the expectation That the resources will be in a specific subnet, and with specific policies. Those same policies can be applied to a CNI IRSA User via Roles. In this scenario, the Apply could create the VPC's LT, Instance Profile, and Policies, that could be used to form the K8s AWS User that is connected to the Identity Provider, while also forming an AWS Role that can begin to define the K8 Cluster's Services, Users, Namespaces, and Contexts. Which means scalling on Scaling EC2s in VPC or within the Cluster Nodes, and Pods in K8s. With a defined set of rules 
 before the creation of physical Resources. It would be the following Apply that would infact create the EC2, which using a Lifecycle Hook for Scaling could trigger the creation of Nodes, Deployments, Services, and Pods. This relationship is almost One directional if you define this one process in that way. Now there are 1000s of different
 combinations of this infrastructure growth. but clearly defining the constraints of relationships in the process while knowing the leverage in resource creation can lead to being able to optimize all aspects while growing 
 hence,Growth Driven  Development. 
 
 I might be Getting a little of topic, but the same rules to define growth, should be able to remain true  for spliting. Just like with DNA, the double helix never stops growing, it is just sometimes, the transition
 is replacing infrastructure, or maybe it is duplicating infrastructure to create a split.
 This is still an idea that is forming. I have a really good understanding of the connections in AWS between
 all of the Infrastructure, Resources, and Services etc... I am still drinking from the firehose with TF and K8s. 
 There are overloaded terms, alot of intriqucies in the orchestrations/integrations for creation/destruction. Infrastructure Automation is such a complex process, there are still a lot of things I need to understand better, however, I'm seeing glimmers of ways to optimize and build resiliant, and robust strategies for operations. I love this stuff.

