
aws_eks_cluster_config = {

      "demo-cluster" = {

        eks_cluster_name         = "demo-cluster1"
        eks_subnet_ids = ["subnet-05984dccc2586358c","subnet-03d4719a9cb0b81d1","subnet-08f4a06c892aa7c6b"]
        tags = {
             "Name" =  "demo-cluster"
         }  
      }
}

eks_node_group_config = {

  "node1" = {

        eks_cluster_name         = "demo-cluster"
        node_group_name          = "myeksnodey"
        nodes_iam_role           = "eks-node-group-general1"
        node_subnet_ids          = ["subnet-05984dccc2586358c","subnet-03d4719a9cb0b81d1","subnet-08f4a06c892aa7c6b"]

        tags={
             Name =  "node1"
         } 
  }
}
