# ci-cd-standards-using-opa
[![Actions Status](https://github.com/ameydev/ci-cd-standards-using-opa/workflows/Build./badge.svg?branch=master)](https://github.com/ameydev/ci-cd-standards-using-opa/actions) [![Actions Status](https://github.com/ameydev/ci-cd-standards-using-opa/workflows/Opa%20tests/badge.svg?branch=master)](https://github.com/ameydev/ci-cd-standards-using-opa/actions)

A github-action to validate your infrastructure configuration manifests (eg. kubernetes resource yaml manifests) against the ci-cd standards using OpenPolicyAgent(OPA).

This action uses [`opa eval`](https://www.openpolicyagent.org/docs/latest/#2-try-opa-eval) command, to make sure that the specifications committed in any of the yaml manifests are not violating the standard policies.


## Usage

## Example workflow.

```yaml
name: Pre-deploy validation of k8s resources.
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: OPA-Test ci-cd manifests standards.
      uses: ameydev/ci-cd-standards-using-opa@master
      env:
        MANIFESTS_PATH_PATTERN: k8s/subpath/ #eg. directoy path or file path k8s/subpath/deploy.yaml
        LIBRARY_PATH: opa-policies/ci-standards #path to your ci-cd policies.
        DATA: data.kubernetes.admission.deny # the policy data 
```

## Use opa command to execute opa unit tests

```yaml
    - name: OPA-Test ci-cd manifests standards.
      uses: ameydev/ci-cd-standards-using-opa@master
      env:
        MANIFESTS_PATH_PATTERN: k8s/subpath/ #eg. directoy path or file path k8s/subpath/deploy.yaml
        LIBRARY_PATH: opa-policies/ci-standards #path to your ci-cd policies.
        DATA: data.kubernetes.admission.deny # the policy data 
      with:
        args: opa test test-data/policies 
```


## Write a CI-CD standard policy using Rego.

You can write any number of standard policies using [Rego language](https://www.openpolicyagent.org/docs/latest/policy-language/)

Example of rego policy which will deny the containers in a pod, running as a root user.
Check more exampples of policies in [`test-data/`](https://github.com/ameydev/ci-cd-standards-using-opa/tree/master/test-data/policies).

```
  package kubernetes.admission

  <!-- Validate Deployment resources -->
  deny[msg] {
    input.kind = "Deployment"
    not input.spec.template.spec.securityContext.runAsNonRoot = true
    msg = "Deployment Standards: Containers must not run as root"
  }

  <!-- Validate Pod resources -->
  deny[msg] {
    input.kind = "Deployment"
    not input.spec.securityContext.runAsNonRoot = true
    msg = "Pod Standards: Containers must not run as root"
  }

```


TODO:
- Terraform, Chef and Puppet support
