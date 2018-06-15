# HackMD

[HackMD](https://hackmd.io) is a realtime, multiplatform collaborative markdown note editor.

## Introduction

This chart bootstraps a [HackMD](https://github.com/hackmdio/docker-hackmd) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It also packages the [PostgreSQL](https://github.com/kubernetes/charts/tree/master/stable/postgresql) which is required for bootstrapping a PostgreSQL deployment for the database requirements of the HackMD application.

## Prerequisites

- Kubernetes 1.8+
- PV provisioner support in the underlying infrastructure

## Install

```console
$ git clone https://github.com/hackmdio/docker-hackmd.git
$ helm install ./docker-hackmd/kubernetes/chart \
    --set image.tag=latest  # Currently, default image tag (0.5.1) doesn't work
                            # This is temporary fix to install HackMD via container image
```

## Configuration

The following configurations may be set. It is recommended to use values.yaml for overwriting the hackmd config.

Parameter | Description | Default
--------- | ----------- | -------
`replicaCount` | How many replicas to run. | 1
`image.repository` | Name of the image to run, without the tag. | [hackmdio/hackmd](https://github.com/hackmdio/docker-hackmd)
`image.tag` | The image tag to use. | 0.5.1
`image.pullPolicy` | The kubernetes image pull policy. | IfNotPresent
`service.name` | The kubernetes service name to use. | hackmd
`service.type` | The kubernetes service type to use. | ClusterIP
`service.externalPort` | Service external port. | 3000
`service.internalPort` | Service internal port. | 3000
`ingress.enabled` | If true, Ingress will be created | `false`
`ingress.annotations` | Ingress annotations | `[]`
`ingress.hosts` | Ingress hostnames | `[]`
`ingress.tls` | Ingress TLS configuration (YAML) | `[]`
`resources` | Resource requests and limits | `{}`
`persistentVolume.enabled` | If true, Persistent Volume Claim will be created | `true`
`persistentVolume.accessModes` | Persistent Volume access modes | `[ReadWriteOnce]`
`persistentVolume.annotations` | Persistent Volume annotations | `{}`
`persistentVolume.existingClaim` | Persistent Volume existing claim name | `""`
`persistentVolume.size` | Persistent Volume size | `2Gi`
`persistentVolume.storageClass` | Persistent Volume Storage Class |  `unset`
`env` | Hackmd environment variables | `{}`
`postgresql.install` | Enable PostgreSQL as a chart dependency | `true`
`postgresql.imageTag` | The image tag for PostgreSQL | `9.6.2`
`postgresql.postgresUser` | PostgreSQL User to create | `hackmd`
`postgresql.postgresPassword` | PostgreSQL Password for the new user | `hackmdpass`
`postgresql.postgresDatabase` | PostgreSQL Database to create | `hackmd`
`postgresql.persistence.enabled` | Enable PostgreSQL persistence using Persistent Volume Claims | `true`
