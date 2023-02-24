# LinkFree

LinkFree is a free and open source alternative to Linktree. It is a single page website that allows you to share all your social media links in one place.

## Kubernetes

Currently, LinkFree is deployed on Kubernetes using the following GitHub repository: [LinkFree Infrastructure](https://github.com/EddieHubCommunity/infrastructure)

It uses Pulumi to deploy LinkFree onto DigitalOcean Kubernetes. We want to modify this so we can use Civo Cloud. Initially I was thinking about using Terraform (which we should cover anyway) but I have been looking at the Civo CLI. I think it would be good to use this as it is a good way to learn about the Civo API.

The `tree` for the current LinkFree infrastructure is:

```bash
├── LICENSE
├── Pulumi.production.yaml
├── Pulumi.yaml
├── README.md
├── package-lock.json
├── package.json
├── src
│   ├── apps
│   │   ├── api
│   │   │   ├── deployment.ts
│   │   │   └── secrets.ts
│   │   └── linkfree.ts
│   ├── databases  
│   │   └── mongo.ts
│   ├── index.ts
│   ├── kubernetes
│   │   ├── cluster.ts
│   │   ├── firewall.ts
│   │   └── secrets.ts
│   ├── monitoring
│   │   ├── grafana.ts
│   │   ├── loki.ts
│   │   └── promtail.ts
│   ├── networking
│   │   ├── cert.ts
│   │   ├── domain.ts
│   │   ├── ingress.ts
│   │   ├── ingressController.ts
│   │   └── nginx.ts
│   ├── storage
│   │   └── spaces.ts
│   └── teleport
│       └── index.ts
└── tsconfig.json
```

## Phase One

1. Sign up for a Civo Cloud account if you haven't already done so.

2. Install the Civo CLI by following the instructions on the [Civo CLI documentation page](https://www.civo.com/learn/installing-and-using-the-civo-cli).

3. Create a new Kubernetes cluster on Civo Cloud using the Civo CLI. You can use the `civo k3s create` command to do this. For example:

`civo k3s create --size g2.small --nodes 3 --region lon1 --wait`

This command will create a new Kubernetes cluster with 3 nodes in the `lon1` region using the `g2.small` instance size. You can adjust the parameters to meet your requirements.

1. Once the cluster is created, use the Civo CLI to retrieve the Kubernetes configuration file and save it to your local machine. You can use the `civo k3s config` command to do this. For example:

`civo k3s config linkfree-cluster > ~/.kube/config`

This command will retrieve the Kubernetes configuration for the `linkfree-cluster` cluster and save it to the `~/.kube/config` file on your local machine.

1. Modify the Pulumi code to deploy LinkFree onto the new Kubernetes cluster on Civo Cloud. You will need to update the Kubernetes configuration settings in the Pulumi code to match the new cluster settings. You may also need to modify other settings such as the storage provider if you plan to use a different provider than DigitalOcean Spaces.

2. Test the deployment to ensure that everything is working as expected. You can use the `pulumi up` command to deploy the updated code and the `pulumi destroy` command to tear down the deployment when you're finished.

This only gets us to the point where we are on Civo Cloud but we still want to migrate away from Pulumi and use Terraform instead.

## Phase Two

1. Create a new Terraform project to deploy LinkFree onto Civo Cloud. You can use the `terraform init` command to create a new project. For example:

`terraform init`

This command will create a new Terraform project in the current directory.

1. Create a new Terraform configuration file to deploy the Kubernetes cluster. You can use the `terraform new-resource` command to create a new configuration file. For example:

`terraform new-resource civo_kubernetes_cluster linkfree-cluster`

This command will create a new Terraform configuration file called `linkfree-cluster.tf` in the current directory.

1. Modify the Terraform configuration file to deploy the Kubernetes cluster. You can use the `terraform show-docs` command to view the documentation for the resource. For example:

`terraform show-docs civo_kubernetes_cluster`

This command will display the documentation for the `civo_kubernetes_cluster` resource.

1. Create a new Terraform configuration file to deploy the LinkFree application. You can use the `terraform new-resource` command to create a new configuration file. For example:

`terraform new-resource kubernetes_deployment linkfree`

This command will create a new Terraform configuration file called `linkfree.tf` in the current directory.

1. Modify the Terraform configuration file to deploy the LinkFree application. You can use the `terraform show-docs` command to view the documentation for the resource. For example:

`terraform show-docs kubernetes_deployment`

This command will display the documentation for the `kubernetes_deployment` resource.

1. Test the deployment to ensure that everything is working as expected. You can use the `terraform apply` command to deploy the updated code and the `terraform destroy` command to tear down the deployment when you're finished.
