# A Guide to Creating a Memcached Elasticache Cluster

This guide will walk you through the process of creating a Memcached Elasticache cluster using Terraform.

## Creating a Memcached Elasticache Cluster

In this exercise, we will create a Memcached Elasticache cluster with two cache nodes.

### Terraform Configuration

Here's an example of how to create a Memcached Elasticache cluster using Terraform:

```hcl
resource "aws_elasticache_cluster" "example" {
cluster_id = "example-memcached-cluster"
engine = "memcached"
node_type = "cache.m3.medium"
num_cache_nodes = 2

tags = {
Name = "example-memcached-cluster"
}
}
```

In this example, we are creating a Memcached Elasticache cluster with the ID `example-memcached-cluster` and two cache nodes of type `cache.m3.medium`.

## Explanation of Terraform Configuration

- The `aws_elasticache_cluster` resource creates an Elasticache cluster with the specified ID, engine, node type, and number of cache nodes.

- The `tags` argument is used to add a tag with the name "example-memcached-cluster" to the cluster.

## Next Steps

Now that you have created a Memcached Elasticache cluster, you can move on to the next exercise. In the next exercise, you will learn how to create an EC2 instance within the VPC and configure it to access the Elasticache cluster.

[//]: # (End of file drills/7-memcached-elasticache-cluster/README.md)
