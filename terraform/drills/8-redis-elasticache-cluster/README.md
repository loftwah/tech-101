# A Guide to Creating a Redis Elasticache Cluster

This guide will walk you through the process of creating a Redis Elasticache cluster using Terraform.

## Creating a Redis Elasticache Cluster

In this exercise, we will create a Redis Elasticache cluster with two cache nodes.

### Terraform Configuration

Here's an example of how to create a Redis Elasticache cluster using Terraform:

```hcl
resource "aws_elasticache_cluster" "example" {
cluster_id = "example-redis-cluster"
engine = "redis"
node_type = "cache.m3.medium"
num_cache_nodes = 2

tags = {
Name = "example-redis-cluster"
}
}
```

In this example, we are creating a Redis Elasticache cluster with the ID `example-redis-cluster` and two cache nodes of type `cache.m3.medium`.

## Explanation of Terraform Configuration

- The `aws_elasticache_cluster` resource creates an Elasticache cluster with the specified ID, engine, node type, and number of cache nodes.

- The `tags` argument is used to add a tag with the name "example-redis-cluster" to the cluster.

## Next Steps

Now that you have created a Redis Elasticache cluster, you can move on to the next exercise. In the next exercise, you will learn how to create an EC2 instance within the VPC and configure it to access the Elasticache cluster.

[//]: # (End of file drills/8-redis-elasticache-cluster/README.md)