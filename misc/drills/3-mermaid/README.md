# Mermaid diagrams

Mermaid is a simple markdown-like script language for generating charts from text via javascript. It works in the VSCode preview pane, and can be exported to SVG or PNG.

## Operoo Deployment

The following diagram shows the steps involved in deploying the Operoo application.

```mermaid
sequenceDiagram
    participant D as DeploymentConfiguration
    participant DT as DeployTools
    participant ACT as ActiveClusterTools
    participant De as Deploy(Standard Deployment)
    participant DS as DeployStandalone(Standalone Deployment)
    participant BD as BackgroundDeployment
    participant AC as AutoScalingGroup
    participant ELB as ElasticLoadBalancer
    D->>De: Initialize
    Note over De: Standard Deployment Process
    De->>DT: Startup Initial Servers
    DT->>De: Running instances
    De->>DT: Create AMI
    DT->>AC: Create ASG with new AMI
    AC-->>De: Return new ASG
    De->>ELB: Switch ELB to new ASG
    ELB-->>De: ELB switched
    De->>ACT: Write New Active Cluster ID
    ACT-->>De: Active cluster details written
    De->>DT: Terminate old instances
    BD->>De: Enqueue deploy job
    Note over DS: Standalone Deployment Process
    DS->>De: Deploy standalone instance
```

The following diagram shows the deployment of the Operoo application to the Australian production environment.

```mermaid
graph LR
    GitHub((GitHub)) -->|Pull Code| CD[Continuous Deployment]
    CD -->|Create AMI| EC2[(EC2 Instance)]
    EC2 -->|Deploy AMI| ASG[AutoScalingGroup]
    subgraph "Australia Production Environment"
    ASG -->|Load Balancer| ELB[(ElasticLoadBalancer)]
    ELB --> PS[Paging Servers<br/>host: groups.operoo.com]
    ELB --> SQ[Slow-Queries Servers<br/>host: groups.operoo.com]
    ELB --> API[API<br/>host: api.operoo.com]
    PS -->|Data| RDS[(RDS Database)]
    PS -->|File Storage| S3[(S3: caremonkey-syd)]
    PS -->|Cache| Elasticache[(Elasticache Redis & Memcached)]
    PS -->|Queue| SQS[(SQS)]
    PS -->|Email Notifications| SES[(SES)]
    PS -->|SMS Notifications| Twilio[(Twilio)]
    PS -->|Push Notifications| SNS[(SNS Notification Service<br/>Push Notifications and Slack notifications)]
    SQ --> RDS
    SQ --> S3
    SQ --> Elasticache
    SQ --> SQS
    SQ --> SES
    SQ --> Twilio
    SQ --> SNS
    API --> RDS
    API --> S3
    API --> Elasticache
    API --> SQS
    API --> SES
    API --> Twilio
    API --> SNS
    end
    style PS fill:#4f0d0d,stroke:#333,stroke-width:2px, color:#000
    style SQ fill:#0c0a40,stroke:#333,stroke-width:2px, color:#000
```
