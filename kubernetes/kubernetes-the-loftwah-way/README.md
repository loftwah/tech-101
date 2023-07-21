# Kubernetes the Loftwah way

This is a guide to running Kubernetes the Loftwah way. It is a collection of best practices and recommendations for running Kubernetes in production.

Inspired by [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way)

## Introduction to Kubernetes

This guide will focus on setting up a basic Kubernetes cluster from scratch. Please ensure that you are familiar with AWS EC2 instances, VPC, IAM, and networking as well as Linux commands and Kubernetes concepts.

To get started, we will be using 3 instances (for simplicity's sake) - 1 master and 2 nodes, but a production-ready setup would require at least 3 masters for high availability. I'll be using Ubuntu 18.04 for the instances.

**1. Setting up AWS instances**

a) Create a new VPC and create three subnets.

**Step 1: Create a VPC**

1. Open the Amazon VPC console at <https://console.aws.amazon.com/vpc/>.
2. In the navigation pane, choose "Your VPCs".
3. Choose "Create VPC".
4. In the "Name tag" field, you can enter the name for your VPC.
5. In the "IPv4 CIDR block" field, you need to specify the IP address range for your VPC. The IP address range can be up to /16 in size (for example, 10.0.0.0/16). Note: This is a critical decision that cannot be changed easily later.
6. You can leave the "IPv6 CIDR block", "Tenancy" (default is fine unless you have specific needs) and "Description" fields at their default settings.
7. Choose "Create".

**Step 2: Create Subnets**

You will generally create at least one subnet in each Availability Zone for redundancy, but for this example we'll just create three subnets within one Availability Zone.

1. In the VPC Dashboard, choose "Subnets".
2. Choose "Create subnet".
3. In the "Name tag" field, you can enter a name for your subnet.
4. In the "VPC" field, select the VPC you just created.
5. In the "Availability Zone" field, you can select an Availability Zone or leave it as "No preference".
6. In the "IPv4 CIDR block" field, specify a subset of the IP address range of your VPC. For example, if your VPC has the range 10.0.0.0/16, you could specify 10.0.0.0/24 for the first subnet, 10.0.1.0/24 for the second subnet, and 10.0.2.0/24 for the third subnet. This would give each subnet 256 addresses (though some are reserved by AWS and not usable).
7. Choose "Create subnet".
8. Repeat these steps to create the second and third subnets, making sure to use a different CIDR block for each.

**Step 3: Modify Auto-Assign IP Settings for Subnets (Optional)**

By default, instances that you launch into a VPC are not assigned a public IPv4 address unless you specified otherwise during launch, or you've modified the subnet's public IPv4 addressing behavior. If you want your instances to automatically have a public IP, do the following:

1. Go to the "Subnets" page in the VPC Dashboard.
2. Select a subnet, and choose "Actions", "Modify auto-assign IP settings".
3. Check the "Auto-assign IPv4" box, then save.

**Remember**: Always consider your security and network requirements before making changes. It's often recommended to only enable auto-assign public IPv4 on subnets in your public-facing subnet (i.e., a subnet that has a route to an Internet Gateway) and keep your backend subnets private (i.e., no direct route to the Internet).

b) Launch three EC2 instances, choose Ubuntu Server 22.04 LTS (HVM), SSD Volume Type. Remember to choose the VPC and subnet you created. Open ports 22 (SSH), 6443 (Kubernetes API server), 2379-2380 (etcd server client API), 10250 (Kubelet API), 10251 (kube-scheduler), 10252 (kube-controller-manager) in the security group.

1. Open the Amazon EC2 console at <https://console.aws.amazon.com/ec2/>.

2. Click "Launch instance".

3. In the "Choose an Amazon Machine Image (AMI)" step, select the "Ubuntu Server 22.04 LTS (HVM), SSD Volume Type" AMI. If it's not listed in the quick start list, search for it in the AWS Marketplace or Community AMIs.

4. In the "Choose an Instance Type" step, select the instance type that meets your needs, and then click "Next: Configure Instance Details".

5. In the "Configure Instance Details" step, select the VPC you created earlier from the "Network" dropdown. Then, for the "Subnet" dropdown, select the first subnet you created.

6. Continue through the steps until you reach "Configure Security Group". Here, click "Create a new security group" and enter a name and description. Add rules to open the following ports:

   * Type: SSH, Protocol: TCP, Port Range: 22, Source: Anywhere (or your IP for better security)
   * Type: Custom TCP, Protocol: TCP, Port Range: 6443, Source: Anywhere
   * Type: Custom TCP, Protocol: TCP, Port Range: 2379-2380, Source: Anywhere
   * Type: Custom TCP, Protocol: TCP, Port Range: 10250, Source: Anywhere
   * Type: Custom TCP, Protocol: TCP, Port Range: 10251, Source: Anywhere
   * Type: Custom TCP, Protocol: TCP, Port Range: 10252, Source: Anywhere

7. Click "Review and Launch", then "Launch".

8. You'll be prompted to select an existing key pair or create a new one. If you don't have one, create a new one. Make sure you download and securely store the .pem file; you'll need it to SSH into your instances. Click "Launch Instances".

9. Repeat the steps to launch two more instances, each in a different subnet.

Remember, only the instance in a subnet with a route to an Internet Gateway will be directly accessible from the internet. Make sure you configure your network access according to your security needs.

c) Note down the private IP addresses of the instances, you'll need them later.

**2. Installing dependencies**

SSH into each instance and install the following:

* Docker
* kubelet
* kubeadm
* kubelet
* kubernetes-cni

For Ubuntu, you can use apt-get. Remember to start and enable Docker and kubelet services.

let's go through the steps needed to install Docker, kubelet, kubeadm, and kubernetes-cni on each of your instances.

Firstly, you'll need to SSH into each instance. Assuming you have a key pair `mykey.pem` and the public IP of your instance is `my.instance.ip.address`, you would do:

```bash
chmod 400 mykey.pem
ssh -i "mykey.pem" ubuntu@my.instance.ip.address
```

Once you're SSH'd into each instance, follow these steps:

**Step 1: Update the system packages**

First, update your system packages.

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

**Step 2: Install Docker**

To install Docker on an Ubuntu machine, we generally suggest installing the Docker Engine straight from Docker's repositories, so you can get the most recent version. Here's a more detailed set of instructions:

**Update your existing list of packages:**

```bash
sudo apt-get update
```

**Install a few prerequisite packages which let apt use packages over HTTPS:**

```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
```

**Then add the GPG key for the official Docker repository to your system:**

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

**Add the Docker repository to APT sources:**

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

**Update the package database with the Docker packages from the newly added repo:**

```bash
sudo apt-get update
```

**Finally, install Docker:**

```bash
sudo apt-get install docker-ce -y
```

**Ensure Docker is running:**

```bash
sudo systemctl status docker
```

The output should show that the service is active and running.

**To make Docker available for non-sudo (non-root) use:**

```bash
sudo usermod -aG docker ${USER}
```

You will need to log out and back in or reboot your machine for these changes to take effect.

With these steps, Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it's running with the following command:

```bash
sudo docker run hello-world
```

This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits. It's a good way to make sure that Docker is working correctly on your system.

**Step 3: Install kubelet, kubeadm, and kubernetes-cni**

You'll need to install some additional packages and set up the Kubernetes repository.

First, install the necessary packages:

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
```

Next, add the Kubernetes GPG key:

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```

Then, add the Kubernetes repository:

```bash
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
```

Finally, update your package list and install kubelet, kubeadm, and kubernetes-cni:

```bash
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubernetes-cni
```

Start and enable kubelet:

```bash
sudo systemctl start kubelet
sudo systemctl enable kubelet
```

You'll need to repeat these steps for each instance.

Remember, the Kubernetes project is rapidly evolving and the installation instructions might change. Be sure to check the [official Kubernetes documentation](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) for the most up-to-date instructions.

**3. Setting up the Kubernetes Master**

Choose one of your instances to be the master node. SSH into the master node and start the Kubernetes master with kubeadm:

```bash
sudo kubeadm init --apiserver-advertise-address=<master-private-ip> --pod-network-cidr=10.244.0.0/16
```

This will start the Kubernetes master and give you a command to join the worker nodes to the master. It'll look something like:

```bash
kubeadm join <master-private-ip>:6443 --token <token> --discovery-token-ca-cert-hash <hash>
```

Save this command, you'll need it later.

**4. Configuring kubectl on the Master Node**

On the master node:

a) To start using your cluster, you need to run the following as a regular user:

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

b) Check the status of the cluster with:

```bash
kubectl get nodes
```

The master node's status will show as NotReady. This is because we haven't set up the network plugin yet.

**5. Setting Up the Network Plugin**

Install Flannel by running this command on the master:

```bash
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

**6. Joining the Worker Nodes to the Master**

SSH into each worker node and run the join command that you saved earlier. It will look like `kubeadm join...`.

Go back to your master node and check the status of your nodes with `kubectl get nodes`. All nodes should be Ready.

Now that you have a Kubernetes cluster running, the next steps are to interact with it, learn how to deploy applications, and understand Kubernetes' features and concepts. Here's a basic outline of things you can do:

## Things to Do After Setting Up Kubernetes

**1. Understanding Kubernetes Components**

Learn about the basic components of Kubernetes - Pod, Service, Volume, Namespace, Deployment, ReplicaSet, StatefulSet, DaemonSet, etc. Try to create these components manually using the `kubectl` command. For example, create a Pod like this:

```bash
kubectl run nginx --image=nginx
```

This command creates a deployment of a single instance of nginx.

Check the pods using:

```bash
kubectl get pods
```

**2. Creating and Managing Deployments**

Deployments describe the desired state for your applications. Kubernetes will manage the actual state to match the desired state. You can scale up your application, rollout updates, or rollback to the previous version with Deployments. Try creating a Deployment with a YAML file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```

Save it as `nginx-deployment.yaml` and run:

```bash
kubectl apply -f ./nginx-deployment.yaml
```

You can then see the deployment:

```bash
kubectl get deployments
```

**3. Creating and Managing Services**

Services define how to access Pods. Try to create a Service to expose the nginx Deployment. Again, you would define the service in a YAML file, like:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
```

Apply it with:

```bash
kubectl apply -f ./nginx-service.yaml
```

Check the service:

```bash
kubectl get services
```

**4. Scaling Applications**

You can scale your application with the `kubectl scale` command. For example, to change the number of nginx replicas to 3, run:

```bash
kubectl scale deployment nginx-deployment --replicas=3
```

Check that the number of Pods has increased to 3:

```bash
kubectl get pods
```

**5. Rolling Updates and Rollbacks**

You can update the application with zero downtime using Kubernetes' rolling updates feature. Try updating the nginx version in your deployment. You can also roll back to the previous version if something goes wrong.

**6. ConfigMaps and Secrets**

Learn how to manage application configurations and sensitive data with ConfigMaps and Secrets.

**7. Persistent Volumes and Claims**

Understand how Kubernetes handles storage with Persistent Volumes and Persistent Volume Claims.

**8. Ingress**

Ingress is an API object that manages external access to services in a cluster, typically HTTP. It can provide load balancing, SSL termination, and name-based virtual hosting.

Remember, a good way to learn Kubernetes is to play with it. Don't be afraid to break things and always try to understand what's happening under the hood. I also recommend the official [Kubernetes Basics tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/), which is an excellent resource for beginners.

## Ruby on Rails

Here's a high-level walkthrough of deploying a Ruby on Rails application with Postgres, Resque and Redis on Kubernetes. This guide assumes that you already have your Kubernetes cluster set up and running.

**1. Dockerize your Ruby on Rails Application**

First, you need to create a Docker image for your Ruby on Rails application. A simple Dockerfile for a Rails app could look like this:

```Dockerfile
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler

# Set the working directory in the image
WORKDIR /myapp

# Copy the Gemfile and install dependencies
COPY Gemfile* ./
RUN bundle install

# Copy the whole app
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
```

Build your Docker image, tag it appropriately, and push it to a Docker registry (like Docker Hub, GitHub or AWS ECR).

**2. Create a Kubernetes Deployment for Rails**

A Kubernetes Deployment ensures that a specified number of Pods (which wrap your app containers) are running at all times. Here's a basic example of a Kubernetes Deployment for a Rails app:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rails-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: rails-app
  template:
    metadata:
      labels:
        app: rails-app
    spec:
      containers:
      - name: rails-app
        image: <your docker image url>
        ports:
        - containerPort: 3000
```

**3. Expose the Rails App with a Service**

Next, create a Service to expose your Rails app:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: rails-service
spec:
  selector:
    app: rails-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: LoadBalancer
```

The LoadBalancer type will expose your Service onto an external IP address, if your environment supports it.

**4. Deploy PostgreSQL**

You can deploy PostgreSQL using a Docker image like the official `postgres` image. Here's a basic example of a Deployment and Service for PostgreSQL:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:latest
        env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: postgres-secret
              key: password
        ports:
        - containerPort: 5432

---

apiVersion: v1
kind: Service
metadata:
  name: postgres-service
spec:
  selector:
    app: postgres
  ports:
  - protocol: TCP
    port: 5432
  targetPort: 5432
```

Notice how we're using a Kubernetes Secret (`postgres-secret`) to store the PostgreSQL password.

**5. Deploy Redis**

Similarly, you can deploy Redis using a Docker image like `redis:latest`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379

---

apiVersion: v1
kind: Service
metadata:
  name: redis-service
spec:
  selector:
    app: redis
  ports:
  - protocol: TCP
    port: 6379
    targetPort: 6379
```

**6. Deploy Resque**

Resque jobs can be executed as separate worker processes. You could create a separate Kubernetes Deployment for Resque workers. In your Dockerfile, you might add a separate command for starting a Resque worker:

```bash
# Start the worker process.
CMD QUEUE=* rake environment resque:work
```

Then, in your Kubernetes Deployment, you'd specify this as the command:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: resque-worker-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: resque-worker
  template:
    metadata:
      labels:
        app: resque-worker
    spec:
      containers:
      - name: resque-worker
        image: <your docker image url>
        command: ["rake", "resque:work"]
```

**7. Configuring the Rails App**

The Rails app will need to connect to the PostgreSQL and Redis services. Use environment variables to configure the database and Redis connections.

This is a high-level guide. In practice, there are many details to manage, such as data persistence for PostgreSQL and Redis, application secrets, health checks, zero-downtime deployments, and scaling.

## K9s

K9s is a terminal-based (TUI) interface that simplifies managing Kubernetes clusters. It provides a simple and productive way to interactively manage applications running in a Kubernetes cluster and to debug live applications.

**Installation**

On macOS, the easiest way to install k9s is via Homebrew, a popular package manager for macOS. If you don't have Homebrew installed, you can install it first by running this command in the terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Once Homebrew (this works on Linuxbrew too) is installed, you can install k9s using the following command:

```bash
brew install derailed/k9s/k9s
```

After installation, you can check the version of k9s with this command:

```bash
k9s version
```

**Basic usage**

To start k9s, simply open your terminal and type `k9s`. This will start k9s and connect to your current Kubernetes context (you can check your current context by running `kubectl config current-context`).

Once k9s starts, you'll be presented with a list of Kubernetes resources in the default namespace of your current context. You can navigate through this list with the arrow keys, page up/down keys, home/end keys, etc.

Here are some basic commands:

* **:all** - This command shows all pods in all namespaces.
* **:namespace\_name** - Replace `namespace_name` with the name of the namespace to view. This command shows all pods in the specified namespace.
* **ctrl-a** - This keybinding shows all available resource shortcuts.
* **/text\_to\_search** - Replace `text_to_search` with the text you want to find. This command searches for text in the current view.
* **esc** - This keybinding takes you back to the previous screen or clears the current command line.
* **ctrl-b** - This keybinding describes the selected resource in detail.

For a full list of commands, you can press `?` while k9s is running.

**Configuration**

K9s keeps its configuration file in `~/.k9s/config.yml`. You can edit this file to customize K9s. For example, you can set a different default namespace, specify a default log viewer, set up plugins, and so on.

K9s also allows you to create cluster-specific and namespace-specific configuration files. Check the [official K9s Github page](https://github.com/derailed/k9s#configuration) for more information.

**Context and Namespace Switching**

You can quickly switch context or namespaces by using the command:

* `:ctx` to switch context
* `:ns` to switch namespace

You can then select the context or namespace from the list, and K9s will switch to it.

Remember, K9s can be a powerful tool for navigating and managing your Kubernetes clusters, but it is still a supplement to `kubectl` and other Kubernetes management tools, not a replacement. Always make sure to understand what's happening behind the scenes when using k9s or similar tools.
